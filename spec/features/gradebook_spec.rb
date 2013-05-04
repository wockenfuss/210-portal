require 'spec_helper'

describe Gradebook, :js => true do
  include Warden::Test::Helpers

  before(:each) do
  	@user = FactoryGirl.create(:user)
  	@gradebook = @user.gradebook
  end

  context "when user is not signed in" do
  	it "requires the user to sign in" do
  		visit user_gradebook_path(@user)
  		page.should have_content("You need to sign in")
  	end
  end

  context "when user is signed in" do
	  before(:each) do
	  	login_as @user, :scope => :user
	  	visit user_gradebook_path(@user)
	  end

	  context "when user is unauthorized" do
	  	let(:user) { FactoryGirl.create(:user) }
	  	it "displays a message that user is unauthorized" do
	  		# user = FactoryGirl.create(:user)
	  		visit user_gradebook_path(user)
	  		page.should have_content("You are not authorized to access this page")
	  	end
	  end

		context "when user is authorized" do
			it "displays a message if no quizzes have been attempted" do
				visit user_gradebook_path(@user)
				page.should have_content("You have no completed quiz attempts")
			end

			context "when quizzes have been attempted" do
				before(:each) do 
					@quiz = FactoryGirl.create(:quiz)
					@attempt = FactoryGirl.create(:attempt, :user_id => @user.id, :quiz_id => @quiz.id)
					@question = FactoryGirl.create(:question)
					@quiz.questions << @question
					@response = FactoryGirl.create(:response, :question_id => @question.id,
																										:attempt_id => @attempt.id,
																										:user_id => @user.id)
				end

				it "displays a list of attempted quizzes" do
					visit user_gradebook_path(@user)
					page.should have_content(@quiz.name)
					page.should have_content("Not yet graded")
				end

				it "displays grades for graded quizzes" do
					@attempt.update_attributes(:graded => true, :score => 3)
					visit user_gradebook_path(@user)
					page.should have_content("3 / 5")
				end

			end
	  end
  
	end
  
end