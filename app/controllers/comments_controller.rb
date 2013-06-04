class CommentsController < ApplicationController
	before_filter :authenticate_user!

	respond_to :js
	def create
		@comment = Comment.create(params[:comment])
		if @comment.save
			respond_with @comment
		else
			#
		end
	end
end