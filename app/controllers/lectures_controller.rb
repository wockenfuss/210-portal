class LecturesController < ApplicationController
	before_filter :store_location
	before_filter :authenticate_user!
	before_filter :parse_lecture_params, :only => [:create, :update]

	layout "lectures", :only => [:show]
	layout "application", :only => [:index, :edit]

	respond_to :html, :js, :json

	def new
		@lecture = Lecture.new
		respond_with @lecture
	end

	def create
		@lecture = Lecture.new(params[:lecture])
		if @lecture.save
			@lectures = Lecture.order('created_at, name')
			# create_file(@lecture)
		else
			# error
		end
	end

	def index
		@lectures = Lecture.order('created_at')
		@lecture = Lecture.new
		authorize! :manage, @lectures
	  respond_with do |format| 
	  	format.html { render 'shared/manage', 
	  												:locals => {
	  														:resource_name => "lecture",
	  														:resources => @lectures
	  														} }
	  end
	end

	def show
		@user = current_user
		@lecture = Lecture.find(params[:id])
		@question = LectureQuestion.new
		@index = @lecture.lecture_questions.count + 1
		if @lecture.lecture_questions.any?
			@comment = Comment.new
		end
		authorize! :read, @lecture
	end

	def edit
		@lecture = Lecture.find(params[:id])
		respond_with @lecture
	end

	def update
		@lecture = Lecture.find(params[:id])
		if @lecture.update_attributes(params[:lecture])
			@lectures = Lecture.order('created_at, name')
			# respond_with @lectures
			flash[:notice] = "Lecture updated"
			js_redirect_to lectures_path
		else
			js_alert(@lecture)
		end
	end

	def destroy
		@lecture = Lecture.find(params[:id])
		@lecture.destroy
		@lectures = Lecture.order('created_at, name')
	end

	private
	def create_file(lecture)
		lecture_file = File.new("app/views/lectures/content/_#{parse_lecture_name(lecture.name)}.html.erb", "w")
    lecture_file.puts(File.readlines('app/views/lectures/content/_boilerplate.html.erb'))
    lecture_file.close
	end

	def parse_lecture_params
		parse_dates(params[:lecture]) if params[:lecture]
  end

end