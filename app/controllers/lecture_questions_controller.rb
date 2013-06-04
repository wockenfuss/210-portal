class LectureQuestionsController < ApplicationController
	before_filter :authenticate_user!

	respond_to :html, :js, :json

	def new
		@lecture = Lecture.find(params[:lecture_id])
		@question = LectureQuestion.new
		@index = @lecture.lecture_questions.count + 1
		respond_with @question, @index
	end

	def create
		@lecture = Lecture.find(params[:lecture_id])
		if @lecture.lecture_questions.create(params[:lecture_question])
			@question = LectureQuestion.new
			@index = @lecture.lecture_questions.count + 1
			respond_with @lecture, @question, @index
		end
	end

	def edit
		@lecture = Lecture.find(params[:lecture_id])
		@question = LectureQuestion.find(params[:id])
		respond_with @lecture, @question
	end

	def update
	end

	def destroy
		@lecture = Lecture.find(params[:lecture_id])
		@question = LectureQuestion.find(params[:id])
		if @question.destroy
			@index = @lecture.lecture_questions.count + 1
			respond_with @lecture, @index
		end
	end
end