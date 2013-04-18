class AttemptsController < ApplicationController
	before_filter :store_location
	before_filter :authenticate_user!
	respond_to :js, :html, :json
	def new
		@attempt = Attempt.new
		@user = User.find(params[:user_id])
		@quiz = Quiz.find(params[:quiz_id])
	end

	def create
		@user = User.find(params[:user_id])
		@quiz = Quiz.find(params[:quiz_id])
		@attempt = Attempt.new(:user_id => @user.id, 
														:quiz_id => @quiz.id, 
														:start_time => Time.now)
		if @attempt.save
			redirect_to attempt_path(@attempt), :notice => "Your quiz is underway"
		end
	end

	def show
		@attempt = Attempt.find(params[:id])
		@quiz = @attempt.quiz
		@response = Response.new
		respond_with(@attempt, @quiz, @response)
	end

	def edit
		@attempt = Attempt.find(params[:id])
		@quiz = @attempt.quiz
		@responses = @attempt.responses
		p @responses
		respond_with(@attempt, @quiz, @responses)
	end

	def update
		@attempt = Attempt.find(params[:id])
		if params[:attempt][:responses_attributes]
			params[:attempt][:responses_attributes].each do |response|
				@response = Response.create(response[1])
				# unless @response.save
				# 	@quiz = @attempt.quiz
				# 	render 'show', :notice => "Something went wrong" and return
				# end
			end
		end
		if @attempt.update_attributes(:end_time => Time.now)
			redirect_to user_root_path(@attempt.user), :notice => "Quiz completed"
		else

		end
	end

	def destroy
		@attempt = Attempt.find(params[:id])
		@quiz = @attempt.quiz
		@attempt.destroy
		redirect_to quiz_path @quiz, :notice => "Attempt deleted"
	end
end
