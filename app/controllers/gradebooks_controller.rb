class GradebooksController < ApplicationController
	before_filter :authenticate_user!
	# load_and_authorize_resource 
	
	def show
		@user = User.find(params[:user_id])
		@gradebook = Gradebook.find(params[:id])
		@attempts = @gradebook.attempts.order("created_at ASC")
	end
end