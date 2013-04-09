class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to user_root_path(current_user), :alert => exception.message
  end

  private
	def after_sign_in_path_for(user)
		user_root_path(:id => user.id)
	end
end
