class QuestionsController < ApplicationController
	respond_to :js, :json

	def new
		@question = Question.new(:multiple_choice => false)
		@quiz = Quiz.find(params[:quiz_id])
		@answers = Answer.new_answers(@question)
		respond_with @question#, @quiz, @answers
	end

	def create
		@quiz = Quiz.find(params[:quiz_id])
		@question = Question.new(params[:question])
		if @question.save
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
			@answers = Answer.new_answers(@question)
		end
		respond_with @question, @quiz, @answers
	end
	
	def update
		@question = Question.find(params[:id])
		@quiz = @question.quizzes.first
		unless params[:question][:multiple_choice] == "true"
			params[:question][:answers_attributes].each do |_, attributes|
				attributes.merge!(:_destroy => '1')
			end
		end
		if @question.update_attributes(params[:question])
			# flash[:notice] = "Question successfully updated"
			@questions = @quiz.questions
			respond_with @questions
		else
			js_alert(@question)
		end
	end

	def destroy
		@question = Question.find(params[:id])
		@quiz = @question.quizzes.first
		@question.destroy
		@questions = @quiz.questions
		respond_with @questions
	end

end
