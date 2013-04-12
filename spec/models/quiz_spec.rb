require 'spec_helper'

describe Quiz do
	subject { FactoryGirl.create(:quiz) }

	it { should validate_presence_of :name }
	# it { should validate_presence_of :release_date }

	[:close_date, :duration, :release_date, :name].each do |attr|
		it { should respond_to attr }
	end

	context "custom validations" do
		it "validates that the closing date is later than the release date" do
			FactoryGirl.build(:quiz, :release_date => Time.now + 10000).should_not be_valid
		end
	end	
end
