class UsersController < ApplicationController

	before_filter :authenticate_user!
	load_and_authorize_resource
	
	def show
		@user = User.find(params[:id])
		@quizzes = Quiz.where("release_date <= :current_time AND close_date >= :current_time", { :current_time => Time.now })
	end

	def index
		@user = current_user
		@users = User.all
	end

end
