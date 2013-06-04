require 'spec_helper'

describe LectureQuestion do
	subject { FactoryGirl.create(:lecture_question) }

	[:content, :lecture_id, :order_index].each do |attr|
		it { should validate_presence_of attr }
		it { should respond_to attr }
	end

end
