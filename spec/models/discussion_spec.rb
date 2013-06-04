require 'spec_helper'

describe Discussion do
  subject { FactoryGirl.create(:discussion) }

  [:name, :content].each do |attr|
  	it { should validate_presence_of attr }
  end

  [:close_date, :content, :release_date, :name].each do |attr|
		it { should respond_to attr }
	end

	describe "#path" do
		before(:each) do
			@discussion = FactoryGirl.create(:discussion)
			@user = FactoryGirl.create(:user)
		end

		it "returns the path to view the discussion" do
			@discussion.path(@user).should eq "/discussions"
		end
	end

	describe ".released" do
		before(:each) do 
			@discussion1 = FactoryGirl.create(:discussion)
			@discussion2 = FactoryGirl.create(:discussion)
			@discussion3 = FactoryGirl.create(:discussion, :release_date => Time.now + 100000)
		end

		it "returns a list of released discussions" do
			Discussion.released.should include @discussion1
			Discussion.released.should include @discussion2
			Discussion.released.should_not include @discussion3
		end
	end

end
