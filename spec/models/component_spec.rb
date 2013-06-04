require 'spec_helper'

describe Component do
  subject { FactoryGirl.create(:component) }

  [:component_index, :unit_id].each do |attr|
		it { should respond_to attr }
	end


	before(:each) do
		@discussion = FactoryGirl.create(:discussion)
		@component = FactoryGirl.create(:component)
		@component.discussions << @discussion
	end

	describe "#element" do 
		it "returns the component it represents" do
			@component.element.should eq @discussion
		end
	end

	describe "#name" do
		it "returns the name of the element it represents" do
			@component.name.should eq @discussion.name
		end
	end

	describe "#path" do
		it "returns the path to it's element" do
			user = FactoryGirl.create(:user)
			@component.path(user).should eq @discussion.path(user)
		end
	end

end
