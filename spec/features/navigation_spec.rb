require 'spec_helper'

describe "Navigation", :js => true do
  include Warden::Test::Helpers

  # let(:user) { FactoryGirl.create(:user) }

  context "root path" do
  	
	  context "when no one is signed in" do
	  	it "renders the sign in page" do
	  		visit root_path
  			page.should have_content("Sign in")
  		end

			it "doesn't allow user to access other users pages" do
				@user = FactoryGirl.create(:user)
				@user.confirm!
				visit user_root_path(@user)
				page.should have_content("You need to sign in or sign up before continuing")
			end
	  end

	  context "When user is signed in" do
			before(:each) do
				@user = FactoryGirl.create(:user)
				@user.confirm!
	      login_as @user, :scope => :user
	      visit root_path
			end

			it "displays the user's email address in the nav bar" do
				page.should have_content(@user.email)
			end

			it "doesn't display a sign in link" do
				page.should_not have_content("Sign In")
			end

			it "displays a sign out link" do
				click_link("#{@user.email}")
				page.should have_content("Sign out")
			end

			it "displays the users show page" do 
				pending
			end
		end
	end

	
end