require 'spec_helper'

describe "Users", :js => true do
  include Warden::Test::Helpers

  let(:user) { FactoryGirl.create(:user) }

  context "the root path" do
	  context "when a user is not signed in" do
	  	it "renders the sign in page" do
	  		visit root_path
	  		page.should have_content("Sign In")
	  	end
	  end
	end
end