require 'spec_helper'

describe Unit do
  subject { FactoryGirl.create(:unit) }

  it { should validate_presence_of :name }

  [:close_date, :name, :release_date].each do |attr|
		it { should respond_to attr }
	end
	
end
