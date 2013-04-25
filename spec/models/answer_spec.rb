require 'spec_helper'

describe Answer do
  subject { FactoryGirl.create(:answer) }

	it { should validate_presence_of :content }
	it { should belong_to :question }

	[:content, :question_id, :index_number].each do |attr|
		it { should respond_to attr }
	end	

	describe ".new_from_question" do
		let(:question) { FactoryGirl.create(:question) }
		let(:answer_params) { {"0"=>{"content"=>"blab", "index_number"=>"0"}, 
														"1"=>{"content"=>"blah", "index_number"=>"1"}, 
														"2"=>{"content"=>"blurg", "index_number"=>"2"}, 
														"3"=>{"content"=>"blub", "index_number"=>"3"} 
													}
												}
		it "creates answers from a list of params" do
			expect do
				Answer.new_from_question(question, answer_params)
			end.to change(Answer, :count).by 4
		end
	end

	describe ".new_answers" do
		let(:question) { FactoryGirl.create(:question) }
		it "creates a list of new answers" do
			answers = Answer.new_answers(question)
			answers.first.id.should be_nil
			answers.last.id.should be_nil
		end
	end
end
