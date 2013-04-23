require 'spec_helper'

describe Response do
	subject { FactoryGirl.create(:response) }

	it { should validate_presence_of :question_id }
	it { should validate_presence_of :user_id }
	it { should validate_presence_of :attempt_id }

	it { should belong_to :user }
	it { should belong_to :question }
	it { should belong_to :attempt }

	[:answer_id, :content, :question_id, :user_id, :attempt_id, :points].each do |attr|
		it { should respond_to attr }
	end

	before(:each) { @response = FactoryGirl.create(:response, :answer_id => 1)}

	describe "#correct_answer?" do
		before(:each) do
			@response.question = FactoryGirl.create(:question, :correct_answer_id => 1)
		end

		it "returns true if the response is correct" do
			@response.correct_answer?.should be_true
		end

		it "returns false if the response is incorrect" do
			@response.question.update_attributes(:correct_answer_id => 2)
			@response.correct_answer?.should be_false
		end
	end

	describe "#calculate_points!" do
		before(:each) do
			@response.question = FactoryGirl.create(:question, :points => 3)
		end

		it "sets its points attribute when response is correct" do
			@response.stub(:correct_answer?).and_return true
			@response.calculate_points!
			@response.points.should eq 3
		end

		it "sets its points attribute when response is false" do
			@response.stub(:correct_answer?).and_return false
			@response.calculate_points!
			@response.points.should eq 0
		end
	end
end
