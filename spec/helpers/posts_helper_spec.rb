require 'spec_helper'

describe PostsHelper do

	describe "#post_form_subject" do
		before(:each) do
			@discussion = FactoryGirl.create(:discussion)
			@discussion_comment = FactoryGirl.create(:post)
		end

		it "appends 'Re:' to a post comment subject heading" do
			post_form_subject(@discussion_comment).should eq "Re: #{@discussion_comment.subject}"
		end

		it "does not append to the subject for a discussion comment" do
			post_form_subject(@discussion).should eq ""
		end
	end

	describe "#strip_domain" do
		it "returns the leading portion of an email address" do
			strip_domain("blab@blab.com").should eq "blab"
		end
	end
end