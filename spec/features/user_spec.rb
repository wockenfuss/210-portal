require 'spec_helper'

describe "User" do
	include Warden::Test::Helpers

	describe "users#show" do
		context "when not signed in" do
			it "requires user to sign in" do
				pending
			end
		end

		context "when signed in" do
			context "when user is not authorized" do
				it "displays a warning message" do
					pending
				end
			end

			context "when user is authorized" do
				it "displays a list of currently open quizzes" do
					pending
				end

				it "displays links for quizzes user has not yet attempted" do
					pending
				end

				it "displays a message for quizzes that have been attempted" do
					pending
				end
			end
		end
	end
end