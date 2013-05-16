require 'spec_helper'

describe "Unit" do
	include Warden::Test::Helpers

	describe "#index" do
		context "when user not signed in" do
			it "requires the user to sign in" do
				pending
			end
		end

		context "when non-admin user" do
			it "does not allow access" do
				pending
			end

			it "displays a warning" do
				pending
			end
		end

		context "when user is an admin" do
			it "displays a list of all units" do
				pending
			end 
		end
	end
end