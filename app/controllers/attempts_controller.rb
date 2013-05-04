class AttemptsController < ApplicationController
	before_filter :store_location
	before_filter :authenticate_user!

	respond_to :js, :html, :json
	def new
		@user = User.find(params[:user_id])
		@quiz = Quiz.find(params[:quiz_id])
		@attempt = @quiz.attempts.build
		@user.attempts << @attempt
		authorize! :new, @attempt
	end

	def create
		@user = User.find(params[:user_id])
		@quiz = Quiz.find(params[:quiz_id])
		@attempt = @quiz.attempts.build(:user_id => @user.id, 
														:quiz_id => @quiz.id, 
														:start_time => Time.now)
		@user.add_role(:quiz_taker)
		authorize! :create, @attempt
		if @attempt.save
			redirect_to edit_attempt_path(@attempt), :notice => "Your quiz is underway"
		end
	end

	def edit
		@attempt = Attempt.find(params[:id])
		@quiz = @attempt.quiz
		@response = Response.new
		authorize! :read, @attempt
		respond_with(@attempt, @response, @quiz)
	end

	def show
		@attempt = Attempt.find(params[:id])
		@quiz = @attempt.quiz
		@responses = @attempt.responses
		# p @responses
		respond_with(@attempt, @quiz, @responses)
	end

	def update
		@attempt = Attempt.find(params[:id])
		if params[:attempt][:responses_attributes]
			params[:attempt][:responses_attributes].each_with_index do |response, index|
				@response = Response.find_or_create_by_id(params[:attempt][:responses_attributes][index.to_s][:id])
				@response.update_attributes(response[1])
			end
		end
		attempt_params = Hash[:end_time => Time.now, :graded => params[:attempt][:graded]]
		if @attempt.update_attributes(attempt_params)
			@attempt.grade! unless @attempt.graded
			if current_user.has_role? :quiz_taker
				@attempt.user.remove_role :quiz_taker
				# flash[:notice] = "Quiz completed"
				# js_redirect_to user_root_path(@attempt.user)
				redirect_to user_root_path(@attempt.user), :notice => "Quiz completed"
			else
				redirect_to quizzes_path
			end
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
