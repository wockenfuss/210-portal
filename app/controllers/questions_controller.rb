class QuestionsController < ApplicationController
	respond_to :js, :json

	def new
		@question = Question.new
		@quiz = Quiz.find(params[:quiz_id])
		respond_with @question, @quiz
	end

	def create
		@quiz = Quiz.find(params[:quiz_id])
		@question = Question.new(params[:question])
		if @question.save
			@quiz.questions << @question
			@questions = @quiz.questions
			respond_with @questions
		else
			js_alert(@question)
		end
	end

	def edit
		@question = Question.find(params[:id])
		@quiz = @question.quizzes.first
		respond_with @question, @quiz
	end
	
	def update
		@question = Question.find(params[:id])
		if @question.update_attributes(params[:question])
			flash[:notice] = "Question successfully updated"
			js_redirect_to(edit_quiz_path(@question.quizzes.first))
		else
			js_alert(@question)
		end
	end

	def index
	end

	def destroy
		@question = Question.find(params[:id])
		@quiz = @question.quizzes.first
		@question.destroy
		flash[:notice] = "Successfully deleted"
		js_redirect_to edit_quiz_path(@quiz)
	end

end
