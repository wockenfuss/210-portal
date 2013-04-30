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

end