class GradebooksController < ApplicationController
	before_filter :authenticate_user!
	load_and_authorize_resource :user
	load_and_authorize_resource :gradebook, :through => :user, :singleton => true
	
	def show
		@user = User.find(params[:user_id])
		@gradebook = @user.gradebook
		@attempts = @gradebook.attempts.order("created_at ASC")
	end
end