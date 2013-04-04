class ApplicationController < ActionController::Base
  protect_from_forgery

  private
	def after_sign_in_path_for(user)
		user_root_path(:id => user.id)
	end
end
