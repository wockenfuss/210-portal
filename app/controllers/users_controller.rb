class UsersController < ApplicationController

	before_filter :authenticate_user!
	load_and_authorize_resource

	respond_to :html, :js, :json
	
	def show
		@user = User.find(params[:id])
		# @units = Unit.current
		p 'user show'
		if params[:time_zone]
			Time.zone = params[:time_zone]
		end
		p Time.now
		@lectures = Lecture.released
		@lectures.each do |lecture|
			p lecture.release_date
			puts lecture.release_date < Time.now
		end
	end

	def index
		@user = current_user
		@users = User.order('name ASC')
	end

	def update
		current_user.remove_role :quiz_taker
		render :json => { :updated => true }
	end

end
