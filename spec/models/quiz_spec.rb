require 'spec_helper'

describe Quiz do
	subject { FactoryGirl.create(:quiz) }

	it { should validate_presence_of :name }

	[:close_date, :duration, :release_date, :name].each do |attr|
		it { should respond_to attr }
	end
end
