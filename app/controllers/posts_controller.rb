class PostsController < ApplicationController
	respond_to :html, :js, :json

	def new
		@user = current_user
		@commentable = Post.find(params[:comment])
		@post = @commentable.posts.build(:user_id => current_user.id)
		respond_with @post
	end

	def create
		@user = User.find(params[:post][:user_id])
		@commentable = get_commentable(params[:post])
		# @discussion = get_discussion(@commentable)
		@current_post = @commentable.posts.build(params[:post])
		if @current_post.save
			# @post = Post.new
			@posts = @commentable.posts
			respond_with @posts
			# redirect_to @commentable
		else
			#error
		end
	end

	private 
	def get_commentable(parameters)
    parameters[:commentable_type].constantize.find(parameters[:commentable_id])
	end

	# def get_discussion(commentable)
	# 	if commentable.class == Discussion
	# 		return commentable
	# 	else
	# 		return get_discussion(commentable.commentable)
	# 	end
	# end
end