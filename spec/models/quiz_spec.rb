require 'spec_helper'

describe Quiz do
	subject { FactoryGirl.create(:quiz) }

	it { should validate_presence_of :name }
	# it { should validate_presence_of :release_date }

	[:close_date, :duration, :release_date, :name].each do |attr|
		it { should respond_to attr }
	end

	before(:each) { @quiz = FactoryGirl.create(:quiz) }

	context "custom validations" do
		it "validates that the closing date is later than the release date" do
			FactoryGirl.build(:quiz, :release_date => Time.now + 100000).should_not be_valid
		end
	end	

	describe "#possible_points" do
		it "returns the total possible number of points for the quiz" do
			question = FactoryGirl.create(:question)
			question2 = FactoryGirl.create(:question)
			@quiz.questions << question
			@quiz.questions << question2
			@quiz.possible_points.should eq 10
		end
	end

	describe "#released?" do
		it "returns true if current datetime is within release and close dates" do
			@quiz.released?.should be_true
		end

		it "returns false if current datetime falls outside release date" do
			@quiz.update_attributes(:release_date => (Time.now + 1000), :close_date => (Time.now + 10000))
			@quiz.released?.should be_false
		end

		it "returns false if current datetime falls outside close date" do
			@quiz.update_attributes(:close_date => (Time.now - 100))
			@quiz.released?.should be_false
		end
	end

	describe ".released_quizzes" do
		before(:each) do
			@quiz1 = FactoryGirl.create(:quiz)
			@quiz2 = FactoryGirl.create(:quiz)
			@unreleased = FactoryGirl.create(:quiz, :release_date => (Time.now - 10000), :close_date => (Time.now - 500))
		end

		it "returns a list of released quizzes" do
			Quiz.released_quizzes.should include(@quiz1, @quiz2)
		end

		it "does not return unreleased quizzes" do
			Quiz.released_quizzes.should_not include @unreleased
		end
	end
end
