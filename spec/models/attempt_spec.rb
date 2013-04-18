require 'spec_helper'

describe Attempt do
	subject { FactoryGirl.create(:attempt) }

	it { should validate_presence_of :quiz_id }
	it { should validate_presence_of :user_id }
	it { should validate_presence_of :start_time }

	[:end_time, :quiz_id, :start_time, :user_id, :graded].each do |attr|
		it { should respond_to attr }
	end	

	before(:each) { @attempt = FactoryGirl.create(:attempt) }

	describe "#completed?" do

		it "returns true if an attempt has been completed" do
			@attempt.update_attributes(:end_time => Time.now )
			@attempt.completed?.should be_true
		end

		it "returns false if an attempt has not been completed" do
			@attempt.update_attributes(:end_time => nil)
			@attempt.completed?.should be_false
		end
	end

	describe "#graded_points" do
		it "calculates the total value of graded points" do
			response_params = { :attempt_id => @attempt.id, :points => 4 }
			response1 = FactoryGirl.create(:response, response_params)
			response2 = FactoryGirl.create(:response, response_params)
			@attempt.graded_points.should eq 8
		end
	end

	describe "#graded?" do
		it "returns true if an attempt has been graded" do
			@attempt.update_attributes(:graded => true)
			@attempt.graded?.should be_true
		end

		it "returns false if an attempt has not been graded" do
			@attempt.update_attributes(:graded => false)
			@attempt.graded?.should be_false
		end
	end
end
