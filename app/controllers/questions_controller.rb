class QuestionsController < ApplicationController
	respond_to :js, :json

	def new
		@question = Question.new(:multiple_choice => false)
		@quiz = Quiz.find(params[:quiz_id])
		@answers = Answer.create_answers(@question)
		respond_with @question, @quiz, @answers
	end

	def create
		@quiz = Quiz.find(params[:quiz_id])
		answers_params = params[:question].delete('answers_attributes')
		@question = Question.new(params[:question])
		if @question.save
			Answer.new_from_question(@question, answers_params) if params[:question][:multiple_choice]
			correct_answer = Answer.where(:question_id => @question.id, :index_number => @question.correct_answer).first
			@question.update_attributes(:correct_answer_id => correct_answer.id) if correct_answer
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
		@answers = @question.answers.order("index_number ASC")
		correct_answer = @answers.where(:id => @question.correct_answer_id).first
		@question.correct_answer = correct_answer.index_number if correct_answer
		if @answers != []
			@question.multiple_choice = true
		else
			@question.multiple_choice = false
			@answers = Answer.create_answers(@question)
		end
		respond_with @question, @quiz, @answers
	end
	
	def update
		@question = Question.find(params[:id])
		answers_params = params[:question].delete('answers_attributes')
		Answer.update_from_question(answers_params) if params[:question][:multiple_choice]
		p params
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
