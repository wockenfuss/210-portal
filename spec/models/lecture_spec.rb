require 'spec_helper'

describe Lecture do
  subject { FactoryGirl.create(:lecture) }

  it { should validate_presence_of :name }

  [:name, :subtitle].each do |attr|
		it { should respond_to attr }
	end

	describe "#path" do
		before(:each) do
			@lecture = FactoryGirl.create(:lecture)
			@user = FactoryGirl.create(:user)
		end

		it "returns the path to view the lecture" do
			@lecture.path(@user).should eq "/lectures/#{@lecture.id}"
		end
	end
end
