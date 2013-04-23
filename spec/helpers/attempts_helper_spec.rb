require 'spec_helper'

describe AttemptsHelper do

	describe "#current_response" do
		before(:each) do
			@question = FactoryGirl.create(:question)
			@attempt = FactoryGirl.create(:attempt)
			@response1 = FactoryGirl.create(:response, 
																			:attempt_id => @attempt.id, 
																			:question_id => @question.id)
			@response2 = FactoryGirl.create(:response, 
																			:attempt_id => @attempt.id,
																			:question_id => 500)
		end

		it "returns existing response for current attempt and question" do
			current_response(@attempt, @question).should eq @response1
		end

		it "returns new response for attempt if one does not yet exist" do
			@attempt2 = FactoryGirl.create(:attempt)
			response = current_response(@attempt2, @question)
			response.id.should be_nil
		end
	end

	describe "#question_grade" do
		let(:question) { FactoryGirl.create(:question, :correct_answer_id => 3) }
		let(:response) { FactoryGirl.create(:response, :answer_id => 3) }
		let(:incorrect_response) { FactoryGirl.create(:response, :answer_id => 4) }

		it "returns the available points for question if response is correct" do
			question_grade(question, response).should eq question.points
		end

		it "returns zero if response is incorrect" do
			question_grade(question, incorrect_response).should eq 0
		end
	end

end