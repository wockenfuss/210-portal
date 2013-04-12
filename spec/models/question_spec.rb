require 'spec_helper'

describe Question do
	subject { FactoryGirl.create(:question) }

	it { should validate_presence_of :content }

	[:content, :correct_answer_id, :name].each do |attr|
		it { should respond_to attr }
	end


end
