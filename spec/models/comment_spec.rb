require 'spec_helper'

describe Comment do
  subject { FactoryGirl.create(:comment) }

	[:commentable_id, :commentable_type, :content, :user_id].each do |attr| 
	  it { should validate_presence_of attr }
	end

  [:commentable_id, :commentable_type, :content, :user_id].each do |attr|
		it { should respond_to attr }
	end
end
