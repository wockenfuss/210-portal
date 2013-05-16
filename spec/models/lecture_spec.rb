require 'spec_helper'

describe Lecture do
  subject { FactoryGirl.create(:lecture) }

  it { should validate_presence_of :name }

  [:name, :unit_id].each do |attr|
		it { should respond_to attr }
	end
end
