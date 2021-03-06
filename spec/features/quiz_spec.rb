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
				# @user.skip_confirmation!
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
				# @admin.skip_confirmation!
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

			it "allows user to cancel out of form" do
				visit new_quiz_path
				click_button "Cancel"
				page.should have_content "Quizzes"
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
					within('form') do
						find_field("Name").value.should eq "Blah"
					end
				end

				it "redirects to quiz edit page on creation of new quiz" do
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
				# @user.skip_confirmation!
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
				# @admin.skip_confirmation!
				@admin.add_role(:admin)
				login_as @admin, :scope => :user
				visit quizzes_path
			end

			it "displays a list of quizzes" do
				page.should have_content @quiz1.name
				page.should have_content @quiz2.name
			end



			it "links to the quizzes show page" do
				within("li:contains('#{@quiz1.name}')") do
					click_link "View"
				end
				page.should have_content(@quiz1.name)
			end

			it "dislays a link to create a new quiz" do
				click_button "New Quiz"
				page.should have_content("Create New Quiz")
			end

			it "allows the user to delete a quiz" do
				within("li:contains('#{@quiz1.name}')") do
					click_link "Delete"
				end
				page.driver.browser.switch_to.alert.accept
				page.should have_content("Successfully deleted")
			end	
		end

	end

	describe "quiz#show" do
		let(:quiz) { FactoryGirl.create(:quiz) }

		context "when no user is signed in" do
			it "requires the user to sign in first" do
				visit quiz_path(quiz)
				page.should have_content("You need to sign in or sign up before continuing")
			end
		end

		context "when user is not an admin" do
			before(:each) do
				@user = FactoryGirl.create(:user)
				# @user.skip_confirmation!
				login_as @user, :scope => :user	
			end

			after(:each) do
				logout(@user)
			end
			
			it "doesn't allow user access" do 
				visit quiz_path(quiz)
				page.should have_content("You are not authorized to access this page")
			end
		end

		context "when user is an admin" do
			before(:each) do
				@admin = FactoryGirl.create(:user)
				# @admin.skip_confirmation!
				@admin.add_role(:admin)
				login_as @admin, :scope => :user
			end			

			context "when attempts exist" do
				before(:each) do
					@user = FactoryGirl.create(:user)
					@attempt = FactoryGirl.create(:attempt, :user_id => @user.id, :quiz_id => quiz.id)
					visit quiz_path(quiz)
				end

				it "displays a list of quiz attempts" do
					page.should have_content(@user.email)
				end

				it "displays a link to grade the quiz" do
					page.should have_link "Grade Attempt", href: edit_attempt_path(@attempt)
				end

			end

			it "displays a message if no attempts have been made" do
				visit quiz_path(quiz)
				page.should have_content("There are no attempts for this quiz.")
			end

		end
	end

	describe "quiz#edit" do
		let(:quiz) { FactoryGirl.create(:quiz) }

		context "when no user is signed in" do
			it "requires the user to sign in first" do
				visit edit_quiz_path(quiz)
				page.should have_content("You need to sign in or sign up before continuing")
			end
		end	

		context "when user is not an admin" do
			before(:each) do
				@user = FactoryGirl.create(:user)
				# @user.skip_confirmation!
				login_as @user, :scope => :user	
			end

			after(:each) do
				logout(@user)
			end
			
			it "doesn't allow user access" do 
				visit edit_quiz_path(quiz)
				page.should have_content("You are not authorized to access this page")
			end
		end

		context "when user is admin" do
			before(:each) do
				@admin = FactoryGirl.create(:user)
				# @admin.skip_confirmation!
				@admin.add_role(:admin)
				login_as @admin, :scope => :user
				visit edit_quiz_path(quiz)
			end

			it "links back to the index page" do
				click_link "Back to quiz list"
				page.should have_content "Quizzes"
			end

			it "displays the quiz" do
				page.should have_content quiz.name
			end

			it "allows user to update quiz" do
				within("div#formContainer") do
					fill_in "Name", :with => "Foo"
				end
				click_button "Update Quiz"
				page.should have_content "Foo"
			end

			it "notifies the user on successful update" do
				within("div#formContainer") do
					fill_in "Name", :with => "Bar"
				end
				click_button "Update Quiz"
				page.should have_content "Quiz successfully updated"
			end

			it "warns user when update fails" do
				within("div#formContainer") do
					fill_in "Name", :with => ""
				end
				click_button "Update Quiz"
				page.should have_content "Name can't be blank"
			end

			it "allows user to delete quiz" do
				click_link "Delete"
				page.driver.browser.switch_to.alert.accept
				page.should have_content("Successfully deleted")
			end

		end

	end


	after{ Warden.test_reset! }
end