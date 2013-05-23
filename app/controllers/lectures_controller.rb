class LecturesController < ApplicationController
	layout "lectures", :only => [:show]

	def index
		@lectures = Lecture.all
	end

	def show
		@user = current_user
		@lecture = Lecture.find(params[:id])
		@question = LectureQuestion.new
		@index = @lecture.lecture_questions.count + 1
		if @lecture.lecture_questions.any?
			@comment = Comment.new
		end
	end

end