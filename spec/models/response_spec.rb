require 'spec_helper'

describe Response do
	subject { FactoryGirl.create(:response) }

	it { should validate_presence_of :question_id }
	it { should validate_presence_of :user_id }
	it { should validate_presence_of :attempt_id }
	it { should validate_presence_of :content }

	[:answer_id, :content, :question_id, :user_id, :attempt_id, :points].each do |attr|
		it { should respond_to attr }
	end
end
