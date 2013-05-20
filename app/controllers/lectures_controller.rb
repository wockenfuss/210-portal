class LecturesController < ApplicationController
	layout "lectures", :only => [:show]

	def index
		@lectures = Lecture.all
	end

	def show
		@user = current_user
		@lecture = Lecture.find(params[:id])
		if @lecture.lecture_questions.any?
			@comment = Comment.new
		end
	end

end