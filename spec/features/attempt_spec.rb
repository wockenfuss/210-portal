require 'spec_helper'

describe "Attempts" do
	include Warden::Test::Helpers

	describe "#new" do

		before(:each) do
			@user = FactoryGirl.create(:user)
			@quiz = FactoryGirl.create(:quiz)
			@quiz.questions << FactoryGirl.create(:question)
		end

		context "when not logged in" do
			it "requires user to log in" do
				visit new_attempt_path(@quiz, @user)
	  		page.should have_content("You need to sign in")
			end
		end

		context "when logged in as a user" do
			before(:each) do
				login_as @user, :scope => :user
				@other_user = FactoryGirl.create(:user)
				visit new_attempt_path(@quiz, @other_user)
			end

			context "when user is not authorized" do
				it "displays warning" do
					page.should have_content("You are not authorized to access this page")
				end

				it "does not allow user to access attempt" do
					page.should_not have_content("once you begin")
				end
			end

			context "when user is authorized" do
				before(:each) { login_as @user, :scope => :user }

				context "when quiz is not available due to release date" do
					it "does not allow user to attempt quiz" do
						@quiz.update_attributes(:release_date => (Time.now + 1000), :close_date => (Time.now + 10000))
						visit new_attempt_path(@quiz, @user)
						page.should have_content("You are not authorized to access this page")
					end
				end

				context "when quiz is not available due to close date" do
					it "does not allow user to attempt quiz" do
						@quiz.update_attributes(:release_date => (Time.now - 1000), :close_date => (Time.now - 500))
						visit new_attempt_path(@quiz, @user)
						page.should have_content("You are not authorized to access this page")
					end
				end

				context "when quiz is available" do
					context "when user has not yet attempted quiz" do
						it "allows user to initiate an attempt" do
							@quiz.update_attributes(:release_date => (Time.now - 1000), :close_date => (Time.now + 1000))
							visit new_attempt_path(@quiz, @user)
							page.should have_button("Begin Quiz")
						end
					end

					context "when user has already attempted quiz" do
						it "does not allow user to initiate an attempt" do
							@user.attempts << FactoryGirl.create(:attempt, :quiz_id => @quiz.id)
							@quiz.update_attributes(:release_date => (Time.now - 1000), :close_date => (Time.now + 1000))
							visit new_attempt_path(@quiz, @user)
							page.should have_content("You are not authorized to access this page")							
						end
					end
				end
			end
		end
	end

	describe "#create" do
		before(:each) do
			@user = FactoryGirl.create(:user)
			@quiz = FactoryGirl.create(:quiz)
			@quiz.questions << FactoryGirl.create(:question)
			login_as @user, :scope => :user
			visit new_attempt_path(@quiz, @user)
		end

		it "creates a new quiz attempt" do
			expect do 
				click_button "Begin Quiz" 
			end.to change(Attempt, :count).by 1			
		end

		it "notifies user that quiz is underway" do
			click_button "Begin Quiz" 
			page.should have_content "Your quiz is underway"
		end
	end

	describe "#edit" do
		before(:each) do
			@user = FactoryGirl.create(:user)
			@quiz = FactoryGirl.create(:quiz)
			@quiz.questions << FactoryGirl.create(:question)
			@attempt = @quiz.attempts << FactoryGirl.build(:attempt, :user_id => @user.id)
		end

		context "when user is not signed in" do
			it "requires user to sign in" do
				visit edit_attempt_path(@attempt)
  			page.should have_content("You need to sign in")
			end
		end

		context "when user is unauthorized" do
			before(:each) do 
				unauthorized = FactoryGirl.create(:user)
				login_as unauthorized, :scope => :user
				visit edit_attempt_path(@attempt)
			end

			it "displays warning" do
				page.should have_content("You are not authorized to access this page")
			end

			it "does not allow user to access attempt" do
				page.should_not have_content("Question")
			end
		end

		context "when user is authorized" do
			before(:each) do
				login_as @user
				@user.add_role :quiz_taker
				visit edit_attempt_path(@attempt)
			end

			it "displays the quiz questions" do
				page.should have_content(@quiz.questions.first.content)
			end

			it "displays a timer" do
				pending
			end

			it "does not display grade option for questions" do
				pending
			end

			it "does not display graded option for quiz" do
				pending
			end

			it "does not display quiz score" do
				pending
			end

			it "allows user to set answers for questions" do
				pending
			end

			it "saves answers each time user updates an answer" do
				pending
			end

			it "warns user on navigation away from page" do
				pending
			end

			it "does not allow user with previous quiz attempt to access quiz" do
				pending
			end

			it "warns user if submitting a quiz with empty answers" do
				pending
			end

			it "allows user to submit quiz" do
				pending
			end

			it "redirects user to home page on submission of quiz" do
				pending
			end
		end
	end

	describe "#show" do

		context "unsigned in user" do
		end

		context "signed in non-admin user" do

		end

		context "admin user" do
			it "displays quiz questions" do
				pending
			end

			it "displays user answers" do
				pending
			end

			it "allows admin to grade answers" do
				pending
			end

			it "does not allow admin to change user answers" do
				pending
			end

			it "allows admin to mark quiz as graded" do
				pending
			end

			it "allows admin to save grades for questions" do
				pending
			end

			it "displays user score for the quiz" do
				pending
			end
		end
	end

end