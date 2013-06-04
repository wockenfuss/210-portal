require 'spec_helper'

describe Question do
	subject { FactoryGirl.create(:question) }

	it { should validate_presence_of :content }
	it { should validate_presence_of :points }

	[:content, :correct_answer_id, :name, :multiple_choice, :points, :correct_answer, :sort_number].each do |attr|
		it { should respond_to attr }
	end


end
