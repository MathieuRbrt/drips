module PostsHelper

	def toggle_like_button(post, user)
		if user.flagged?(post)
			link_to "Unlike", like_post_path(post)
		else
			link_to "Like", like_post_path(post)
		end
	end

	def likes_plural(post)
		if post.flaggings.count == 0
			""
		elsif post.flaggings.count == 1
			post.likes + " Like - "
		else
			post.likes + " Likes - "
		end
	end

end
