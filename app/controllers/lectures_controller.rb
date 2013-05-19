class LecturesController < ApplicationController
	layout "lectures", :only => [:show]

	def index
		@lectures = Lecture.all
	end

	def show
		@lecture = Lecture.find(params[:id])
	end

end