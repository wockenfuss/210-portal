class LectureQuestionsController < ApplicationController
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
			redirect_to lecture_path(@lecture), :notice => "Question created"
		else
			render 'lecture_questions/new', :notice => "Something went wrong"
		end
	end

	def destroy
		@lecture = Lecture.find(params[:lecture_id])
		@question = LectureQuestion.find(params[:id])
		if @question.destroy
			respond_with @lecture
		end
	end
end