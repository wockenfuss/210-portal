class QuizzesController < ApplicationController
	before_filter :authenticate_user!
	load_and_authorize_resource
	# respond_to :html, :json, :js

	def index
		@quizzes = Quiz.all
	end

	def show
		@quiz = Quiz.find(params[:id])
	end

	def new
		@quiz = Quiz.new
	end

	def create
		@quiz = Quiz.new(params[:quiz])
		if @quiz.save
			flash[:notice] = "Quiz successfully created"
			js_redirect_to quiz_path(@quiz)
		else
			# flash.now[:alert] = "There was a problem creating the quiz"
			# render 'new'
			js_alert(@quiz)
		end
	end

	def edit
	end

	def update
	end

	def delete
	end

end
