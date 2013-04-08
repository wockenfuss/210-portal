require 'spec_helper.rb'

describe "Roles", :js => true do
	include Warden::Test::Helpers

	context "when logged in as admin" do
		before(:each) do
			@admin = FactoryGirl.create(:user)
			@admin.confirm!
			@admin.add_role(:admin)
			login_as @admin, :scope => :user
			visit root_path
		end

		it "root path displays admin options" do
			page.should have_content("Manage")
		end
	end

	context "when no user is logged in" do
		it "root path doesn't display admin options" do
			visit root_path
			page.should_not have_content("Manage")
		end
	end

	context "when non-admin user is logged in" do
		before(:each) do
			@user = FactoryGirl.create(:user)
			@user.confirm!
			login_as @user, :scope => :user
			visit root_path
		end

		it "root path doesn't display admin options" do
			page.should_not have_content("Manage")
		end
	end

end