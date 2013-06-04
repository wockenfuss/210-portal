module PostsHelper

	def post_form_subject(commentable)
		if commentable.class == Post
			return "Re: #{commentable.subject}"
		else
			return ""
		end
	end

	def strip_domain(address)
    address.slice(/(.*)@/, 1)
  end

end