require 'spec_helper'

describe "Question", :js => true do
  include Warden::Test::Helpers

  before(:each) do
    @admin = FactoryGirl.create(:user)
    # @admin.skip_confirmation!
    @admin.add_role(:admin)
    login_as @admin, :scope => :user
    @quiz = FactoryGirl.create(:quiz)
    visit edit_quiz_path(@quiz)
  end

  describe "#new" do
    shared_examples_for "a question" do
      it "allows user to save a question" do
        expect do 
          within('#addQuestionForm') do
            find(:css, 'input[type="submit"]').click
          end
          visit edit_quiz_path(@quiz)
        end.to change(Question, :count).by 1
      end

      it "displays a warning if question is invalid" do
        fill_in "Content", :with => ""
        within('#addQuestionForm') do
          find(:css, 'input[type="submit"]').click
        end
        page.should have_content("Content can't be blank")
      end
    end

    context "multiple choice question" do
      before(:each) do 
        click_link("Add Questions")
        within('#addQuestionForm') do
          find("#question_multiple_choice_true").click
          fill_in 'Name', :with => "Whoo"
          fill_in "Points", :with => 2
          fill_in "Content", :with => "How?"
          fill_in("question_answers_attributes_0_content", :with => "a")
          fill_in("question_answers_attributes_1_content", :with => "b")
          fill_in("question_answers_attributes_2_content", :with => "c")
          fill_in("question_answers_attributes_3_content", :with => "d") 
          choose('question_correct_answer_0')       
        end
      end

      it_behaves_like "a question"

      it "creates associated answers for the multiple choice question" do
        expect do
          click_button "Create Question" 
          visit edit_quiz_path(@quiz)
        end.to change(Answer, :count).by 4
      end

      it "requires user to specify correct answer" do
        pending
      end

    end

    context "essay question" do
      before(:each) do
        click_link("Add Questions")
        within('#addQuestionForm') do
          fill_in 'Name', :with => "Whee"
          fill_in "Points", :with => 1
          fill_in "Content", :with => "Why?"
        end
      end

      it_behaves_like "a question"

      it "doesn't create associated answers" do
        expect do
          click_button "Create Question"
          visit edit_quiz_path(@quiz)
        end.to change(Answer, :count).by 0
      end

      it "doesn't set a correct answer" do
        pending
      end

    end

  	it "displays questions in order by creation date by default" do
      pending
  	end

  	it "allows user to reorder questions" do
  		pending
  	end

  end

  describe "#edit" do
    before(:each) do
      @essay_question = FactoryGirl.create(:question)
      @quiz.questions << @essay_question
      visit edit_quiz_path(@quiz)
      find(:css, 'a[data-question="' + @essay_question.id.to_s + '"]').click
      within('#addQuestionForm') do
        fill_in "Name", :with => "yippee"
      end
    end

    it "updates a question" do
      within('#addQuestionForm') do
        find(:css, 'input[type="submit"]').click
      end
      visit edit_quiz_path(@quiz)
      within('#questionContainer') do
        find(:css, 'a[data-question="' + @essay_question.id.to_s + '"]').text.should include("yippee")
      end
    end

    it "displays a warning if question is invalid" do
      within('#addQuestionForm') do
        fill_in "Content", :with => ""
        find(:css, 'input[type="submit"]').click
      end
      page.should have_content("Content can't be blank")
    end

    it "allows user to change question from essay to multiple choice" do
      within('#addQuestionForm') do
        find("#question_multiple_choice_true").click
        fill_in("question_answers_attributes_0_content", :with => "a")
        fill_in("question_answers_attributes_1_content", :with => "b")
        fill_in("question_answers_attributes_2_content", :with => "c")
        fill_in("question_answers_attributes_3_content", :with => "d") 
        choose('question_correct_answer_0')
        find(:css, 'input[type="submit"]').click       
      end
      visit edit_quiz_path(@quiz)
      find(:css, 'a[data-question="' + @essay_question.id.to_s + '"]').click
      find(:css, "#question_multiple_choice_true").should be_checked
      @essay_question.answers.count.should eq 4
    end

    it "allows user to delete questions" do
      expect do
        find(:css, '.deleteButton').click
        page.driver.browser.switch_to.alert.accept
        visit edit_quiz_path(@quiz)
      end.to change(Question, :count).by -1
    end

    context "multiple choice question" do
      before(:each) do
        @mc_question = FactoryGirl.create(:question)
        @quiz.questions << @mc_question
        4.times { FactoryGirl.create(:answer, :question_id => @mc_question.id) }
        visit edit_quiz_path(@quiz)
        find(:css, 'a[data-question="' + @mc_question.id.to_s + '"]').click
      end

      it "allows user to change question from multiple choice to essay" do
        find("#question_multiple_choice_false").click
        within('#addQuestionForm') do
          find(:css, 'input[type="submit"]').click
        end
        visit edit_quiz_path(@quiz)
        find(:css, 'a[data-question="' + @mc_question.id.to_s + '"]').click
        find(:css, "#question_multiple_choice_false").should be_checked
        @mc_question.answers.count.should eq 0
      end

      it "displays a warning if answers are invalid" do
        fill_in("question_answers_attributes_0_content", :with => "")
        within('#addQuestionForm') do
          find(:css, 'input[type="submit"]').click
        end
        page.should have_content("Answers content can't be blank")
      end

      it "allows user to change correct answer" do
        pending
      end

      it "deletes associated answers when multiple choice question is deleted" do
        expect do
          find(:css, 'a[href="/questions/' + @mc_question.id.to_s + '"]').click
          page.driver.browser.switch_to.alert.accept
          visit edit_quiz_path(@quiz)
        end.to change(Answer, :count).by -4
      end

    end

  end
  after{ Warden.test_reset! }

end