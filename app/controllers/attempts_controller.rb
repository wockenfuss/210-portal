class AttemptsController < ApplicationController
	respond_to :js, :html, :json
	def new
		@attempt = Attempt.new
		@user = User.find(params[:user_id])
		@quiz = Quiz.find(params[:quiz_id])
	end

	def create
		@user = User.find(params[:user_id])
		@quiz = Quiz.find(params[:quiz_id])
		@attempt = Attempt.new(:user_id => @user.id, :quiz_id => @quiz.id, :start_time => Time.now)
		if @attempt.save
			@user.attempts << @attempt
			@quiz.attempts << @attempt
			redirect_to attempt_path(@attempt), :notice => "Your quiz is underway"
		end
	end

	def show
		@attempt = Attempt.find(params[:id])
		@quiz = @attempt.quiz
		respond_with(@attempt, @quiz)
	end

	def update
		@attempt = Attempt.find(params[:id])
		if @attempt.update_attributes(:end_time => Time.now)
			redirect_to user_root_path(@attempt.user), :notice => "Quiz completed"
		else

		end
	end
end
