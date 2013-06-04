require 'spec_helper'

describe Unit do
  subject { FactoryGirl.create(:unit) }

  it { should validate_presence_of :name }

  [:close_date, :name, :release_date].each do |attr|
		it { should respond_to attr }
	end

	describe ".current" do
		before(:each) do 
			@unit1 = FactoryGirl.create(:unit)
			@unit2 = FactoryGirl.create(:unit)
			@unit3 = FactoryGirl.create(:unit, :release_date => Time.now + 100000)
		end
		it "returns a list of released units" do
			Unit.current.should include @unit1
			Unit.current.should include @unit2
			Unit.current.should_not include @unit3
		end
	end
	
end
