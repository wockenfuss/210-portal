class DiscussionsController < ApplicationController
	respond_to :html, :json, :js
	before_filter :parse_discussion_params, :only => [:create, :update]


	def create
		@discussion = Discussion.new(params[:discussion])
		if @discussion.save
			@discussions = Discussion.order('release_date, created_at')
			# respond_with @discussions
		else 
			puts "error"
			#post error
		end
	end

	def show
		@discussion = Discussion.find(params[:id])
		respond_with @discussion
	end

	def index
		@discussion = Discussion.new
		@discussions = Discussion.order('release_date, created_at')
		if params[:manage] == "true"
		  respond_with do |format| 
		  	# format.html { render 'discussions/manage' }
		  	format.html { render 'shared/manage', 
		  												:locals => {
		  														:resource_name => "discussion",
		  														:resources => @discussions
		  														} }
		  end
		else
			respond_with @discussions
		end
	end

	def edit
		@discussion = Discussion.find(params[:id])
	end

	def update
		@discussion = Discussion.find(params[:id])
		if @discussion.update_attributes(params[:discussion])
			# redirect_back_or_default
			js_redirect_to manage_discussions_path(:manage => true)
		else
			#display warning
		end
	end


	def destroy
		@discussion = Discussion.find(params[:id])
		@discussion.destroy
		@discussions = Discussion.order('release_date, created_at')
		respond_with @discussions
	end

	private
	def parse_discussion_params
  	parse_dates(params[:discussion])
  end


end