class ApplicationController < ActionController::Base
  protect_from_forgery

  def store_location
    session[:return_to] = request.url
  end

  def redirect_back_or_default(default) 
    redirect_to(session[:return_to] || default) 
    session[:return_to] = nil 
  end 

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to user_root_path(current_user), :alert => exception.message
  end

	def js_redirect_to(path)
  	render js: %(window.location.href='#{path}') and return
	end
  
  def js_alert(current_object)
  	render "shared/errors", :locals => { :current_object => current_object, :target => targetId(current_object) }
  end

  private
	def after_sign_in_path_for(user)
		user_root_path(:id => user.id)
	end

  def targetId(object)
    case object
    when @question
      return '#questionErrors'
    when @quiz
      return '#errors'
    end
  end
end
