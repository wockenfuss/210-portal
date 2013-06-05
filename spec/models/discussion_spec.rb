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

	describe "#open?" do
		before(:each) do 
			@open_1 = FactoryGirl.create(:discussion)
			@open_2 = FactoryGirl.create(:discussion, :close_date => Time.now + 100000)
			@unreleased = FactoryGirl.create(:discussion, :release_date => Time.now + 100000)
			@closed = FactoryGirl.create(:discussion, 
																		:release_date => Time.now - 200000,
																		:close_date => Time.now - 100000)
		end

		it "returns true if discussion has been released and not closed" do
			@open_1.open?.should be_true
			@open_2.open?.should be_true
		end

		it "returns false if discussion has not been released" do
			@unreleased.open?.should be_false
		end

		it "returns false if discussion has been closed" do
			@closed.open?.should be_false
		end
	end

end
