require 'spec_helper'

describe "Quiz", :js => true do 
	include Warden::Test::Helpers

	describe "quizzes#new" do
		context "when no user is signed in" do
			it "requires the user to sign in first" do
				visit new_quiz_path
				page.should have_content("You need to sign in or sign up before continuing")
			end
		end

		context "when user is not an admin" do
			before(:each) do
				@user = FactoryGirl.create(:user)
				@user.confirm!
				login_as @user, :scope => :user	
			end

			after(:each) do
				logout(@user)
			end
			
			it "doesn't allow user access" do 
				visit new_quiz_path
				page.should have_content("You are not authorized to access this page")
			end
		end

		context "when user is an admin" do
			before(:each) do
				@admin = FactoryGirl.create(:user)
				@admin.confirm!
				@admin.add_role(:admin)
				login_as @admin, :scope => :user
			end

			after(:each) do
				logout(@admin)
			end

			it "displays a quiz form" do 
				visit new_quiz_path
				page.should have_content("Create New Quiz")
			end

			context "for a valid quiz" do
				before(:each) do
					visit new_quiz_path
	        fill_in 'Name', :with => "Blah"
	        fill_in 'Duration', :with => 10
	        fill_in 'Release date', :with => "4/6/2013"
	        fill_in 'Close date', :with => "4/8/2013"
	        click_button "Create Quiz"
				end

				it "allows for creation of new quiz" do
					pending
				end

				it "redirects to quiz show page on creation of new quiz" do
				  page.should have_content "Blah"
				end

				it "displays confirmation of creation of new quiz" do
					page.should have_content "Quiz successfully created"
				end
			end

			
			it "displays warning if quiz cannot be created" do
				visit new_quiz_path
				click_button "Create Quiz"
				page.should have_content "Name can't be blank"
			end
		end
	end

	describe "quiz#index" do
		context "when no user is signed in" do
			it "requires the user to sign in first" do
				visit quizzes_path
				page.should have_content("You need to sign in or sign up before continuing")
			end
		end	

		context "when user is not an admin" do
			before(:each) do
				@user = FactoryGirl.create(:user)
				@user.confirm!
				login_as @user, :scope => :user	
			end

			after(:each) do
				logout(@user)
			end
			
			it "doesn't allow user access" do 
				visit quizzes_path
				page.should have_content("You are not authorized to access this page")
			end
		end

		context "when user is an admin" do
			before(:each) do
				@quiz1 = FactoryGirl.create(:quiz)
				@quiz2 = FactoryGirl.create(:quiz)
				@admin = FactoryGirl.create(:user)
				@admin.confirm!
				@admin.add_role(:admin)
				login_as @admin, :scope => :user
				visit quizzes_path
			end

			it "displays a list of quizzes" do
				page.should have_content @quiz1.name
				page.should have_content @quiz2.name
			end

			it "allows the user to edit a quiz" do
				pending
			end

			it "links to the quizzes show page" do
				pending
			end

			it "dislays a link to create a new quiz" do
				pending
			end

			it "allows the user to delete a quiz" do
				pending
			end	
		end

	end
	after{ Warden.test_reset! }
end