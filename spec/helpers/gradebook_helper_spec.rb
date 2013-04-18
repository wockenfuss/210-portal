require 'spec_helper'

describe "GradebookHelper" do
	helper GradebookHelper

	describe "#calculated_grade" do
		it "returns the correct grade for an attempt" do
			@quiz = FactoryGirl.create(:quiz)
			@question = FactoryGirl.create(:question, :points => 8)
			@quiz.questions << @question
			@attempt = FactoryGirl.create(:attempt, :quiz_id => @quiz.id)
			@response = FactoryGirl.create(:response, :question_id => @question.id, 
																		:attempt_id => @attempt.id,
																		:points => 7)
			calculated_grade(@attempt).should eq "7 / 8"
		end
	end
end