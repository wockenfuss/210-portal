class UsersController < ApplicationController

	before_filter :authenticate_user!
	load_and_authorize_resource
	
	def show
		@user = User.find(params[:id])
	end

	def index
		@user = current_user
		@users = User.all
	end

end
