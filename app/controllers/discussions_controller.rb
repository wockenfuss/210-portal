class DiscussionsController < ApplicationController
	before_filter :authenticate_user!
	load_and_authorize_resource

	respond_to :html, :json, :js
	before_filter :parse_discussion_params, :only => [:create, :update]


	def create
		@discussion = Discussion.new(params[:discussion])
		p params[:action]

		if @discussion.save
			@discussions = Discussion.order('release_date, created_at')
			# respond_with @discussions
		else 
			puts "error"
			#post error
		end
	end

	def show
		@user = current_user
		@discussions = Discussion.released
		@discussion = Discussion.find(params[:id])
		puts @discussion
		if @discussions.include?(@discussion)		
			puts "include"
			@post = Post.new
			@commentable = @discussion
			@posts = @discussion.posts
			respond_with @discussion
		else
			redirect_to discussions_path, :error => "Discussion is unavailable"
		end
	end

	def index
		if params[:manage] == "true"
			@discussion = Discussion.new
			@discussions = Discussion.order('release_date, created_at')
			authorize! :manage, @discussions
		  respond_with do |format| 
		  	# format.html { render 'discussions/manage' }
		  	format.html { render 'shared/manage', 
		  												:locals => {
		  														:resource_name => "discussion",
		  														:resources => @discussions
		  														} }
		  end
		else
			@discussions = Discussion.released
			@discussion = Discussion.released.last
			respond_with @discussions, @discussion
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
  	if params[:action] == "create"
	  	content = params[:discussion][:content] 
			params[:discussion][:content] = "<p>" + content + "</p>"
		end
  end


end