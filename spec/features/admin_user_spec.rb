require 'spec_helper.rb'

describe "Roles", :js => true do
	include Warden::Test::Helpers

	before(:each) do 
		@user = FactoryGirl.create(:user)
		# @user.skip_confirmation!
		@admin = FactoryGirl.create(:user)
		# @admin.skip_confirmation!
		@admin.add_role(:admin)
	end

	context "when logged in as admin" do
		before(:each) do
			login_as @admin, :scope => :user
			visit root_path
		end

		it "root path displays admin options" do
			page.should have_content("Manage")
		end

		it "allows admin to access other users pages" do
			visit user_root_path(@user)
			page.should have_content @user.email
		end

		it "allows admin to view users index" do
			visit users_path
			page.should_not have_content("You are not authorized to access this page")
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
			login_as @user, :scope => :user
			visit root_path
		end

		it "root path doesn't display admin options" do
			page.should_not have_content("Manage")
		end

		it "doesn't allow user to view other users pages" do
			visit user_root_path(@admin)
			page.should have_content("You are not authorized to access this page")
		end

		it "doesn't allow user to view users index" do
			visit users_path
			page.should have_content("You are not authorized to access this page")
		end
	end

end