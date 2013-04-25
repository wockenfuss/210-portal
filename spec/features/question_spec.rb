require 'spec_helper'

describe "Question", :js => true do
  include Warden::Test::Helpers

  describe "#new" do
    before(:each) do
      @admin = FactoryGirl.create(:user)
      # @admin.skip_confirmation!
      @admin.add_role(:admin)
      login_as @admin, :scope => :user
      @quiz = FactoryGirl.create(:quiz)
      visit edit_quiz_path(@quiz)
    end

    # context "when admin" do
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

      it "allows user to create a multiple choice question" do
        expect do
          click_button "Create Question" 
          # within('#questionContainer') do
          #   page.should have_content("Whoo")
          # end
          visit edit_quiz_path(@quiz)
        end.to change(Question, :count).by 1
      end

      it "creates answers for the multiple choice question" do
        expect do
          click_button "Create Question" 
          visit edit_quiz_path(@quiz)
        end.to change(Answer, :count).by 4
      end

    end

    	it "allows user to create an essay question" do
    		click_link("Add Questions")
        within('#addQuestionForm') do
          fill_in 'Name', :with => "Whee"
          fill_in "Points", :with => 1
          fill_in "Content", :with => "Why?"
        end
        click_button "Create Question" 
        within('#questionContainer') do
          page.should have_content("Whee")
        end
    	end

    	it "displays questions in order by creation date by default" do
        # question1 = FactoryGirl.create(:question)
        # question2 = FactoryGirl.create(:question)
        # @quiz.questions << question1 << question2
        # visit edit_quiz_path(@quiz)
        pending
    	end

    	it "allows user to reorder questions" do
    		pending
    	end

    	it "allows user to specify correct answer for multiple choice question" do
    		pending
    	end

      it "displays warning if question has invalid info" do
        pending
      end
    end
  end

  describe "#edit" do

    context "when admin" do
      it "allows user to update a question" do
        pending
      end

      it "allows user to change question from multiple choice to essay" do
        pending
      end

      it "allows user to change question from essay to multiple choice" do
        pending
      end

      it "displays a notice if the question is updated with invalid information" do
        pending
      end

      it "allows user to delete questions" do
        pending
      end

    end
  # end
end