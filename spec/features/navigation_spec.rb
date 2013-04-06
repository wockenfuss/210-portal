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
				page.should have_content("Sign Out")
			end

			it "displays the users show page" do 
				pending
			end
		end
	end

	
end