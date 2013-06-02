module PostsHelper

	def post_form_subject(commentable)
		if commentable.class == Post
			return "Re: #{commentable.subject}"
		else
			return ""
		end
	end

end