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
			js_alert(@quiz)
		end
	end

	def edit
		@quiz = Quiz.find(params[:id])
	end

	def update
	end

	def destroy
		@quiz = Quiz.find(params[:id])
		@quiz.destroy
		redirect_to quizzes_path, :notice => "Successfully deleted"
	end

end
