require 'spec_helper'

describe User do
	subject { FactoryGirl.create(:user) }

	it { should validate_presence_of :email }
	it { should ensure_length_of(:password).is_at_least(8) }

	[:email, :password, :password_confirmation].each do |attr|
		it { should respond_to attr }
	end

	before(:each) do
		@user = FactoryGirl.create(:user)
		# @user.skip_confirmation!
		@quiz = FactoryGirl.create(:quiz)
	end

	describe "#attempted?" do
		it "returns true if user has attempted the given quiz" do	
			attempt = FactoryGirl.create(:attempt, :user_id => @user.id, :quiz_id => @quiz.id)
			@user.attempted?(@quiz).should be_true
		end

		it "returns false if user has not attempted quiz" do
			@user.attempted?(@quiz).should be_false
		end
	end

	describe "#graded_attempts" do

		it "returns a list including only graded attempts" do
			ungraded_params = {:user_id => @user.id, :quiz_id => @quiz.id}
			graded_params = ungraded_params.merge(:graded => true)
			attempt = FactoryGirl.create(:attempt, graded_params)
			attempt2 = FactoryGirl.create(:attempt, graded_params)
			attempt3 = FactoryGirl.create(:attempt, ungraded_params)
			@user.graded_attempts.include?(attempt).should be_true
			@user.graded_attempts.include?(attempt2).should be_true
			@user.graded_attempts.include?(attempt3).should be_false
		end
	end

end
