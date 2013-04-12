class QuizzesController < ApplicationController
	before_filter :authenticate_user!
	before_filter :format_date, :only => [:create, :update]

	load_and_authorize_resource
	# respond_to :html, :json, :js

	def index
		@quizzes = Quiz.all
	end

	def new
		@quiz = Quiz.new
	end

	def create
		@quiz = Quiz.new(params[:quiz])
		if @quiz.save
			flash[:notice] = "Quiz successfully created"
			js_redirect_to quizzes_path
		else
			js_alert(@quiz)
		end
	end

	def edit
		@quiz = Quiz.find(params[:id])
	end

	def update
		@quiz = Quiz.find(params[:id])
		if @quiz.update_attributes(params[:quiz])
			flash[:notice] = "Quiz successfully updated"
			js_redirect_to(quizzes_path)
		else
			js_alert(@quiz)
		end
	end

	def destroy
		@quiz = Quiz.find(params[:id])
		@quiz.destroy
		redirect_to quizzes_path, :notice => "Successfully deleted"
	end

	private

	def format_date
		release = params[:quiz][:release_date] || ""
		close = params[:quiz][:close_date] || ""
		params[:quiz][:release_date] = test_date(release) unless release == ""
		params[:quiz][:close_date] = test_date(close) unless close == ""
	end

	def test_date(string)
		begin
			string = DateTime.strptime(string, '%Y-%m-%d %H:%M:%S')
		rescue => error
			string = DateTime.strptime(string, '%m/%d/%Y')
		end
		string
	end

end
