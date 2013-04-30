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

	describe "#grade!" do
		before(:each) do
			response_params = { :attempt_id => @attempt.id }
			response = FactoryGirl.create(:response, response_params)
			response2 = FactoryGirl.create(:response, response_params)
			@attempt.quiz = FactoryGirl.create(:quiz, :autograde => true)
			Response.any_instance.stub(:calculate_points!).and_return(4)
			@attempt.grade!
		end

		it "assigns the correct score to a completed attempt" do	
			@attempt.score.should eq 8
		end

		it "sets the attempt to graded if quiz is autograded" do
			@attempt.graded.should be_true
		end
	end

	describe "#released?" do
		before(:each) do
			@attempt.quiz = FactoryGirl.create(:quiz)
		end
		it "returns true if attempt belongs to a released quiz" do
			@attempt.released?.should be_true
		end

		it "returns false if attempt belongs to unreleased quiz" do
			@attempt.quiz.update_attributes(:release_date => Time.now + 5000)
			@attempt.released?.should be_false
		end
	end
end
