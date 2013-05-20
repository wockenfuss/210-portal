class CommentsController < ApplicationController
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