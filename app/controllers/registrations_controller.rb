class RegistrationsController < Devise::RegistrationsController

	def update
		@user = User.find_by_email(params[:user][:email])
	  if @user.update_with_password(params[:user])
	    sign_in(@user, :bypass => true)
	    flash[:notice] = 'Password updated.'
	    redirect_to user_root_path(@user)
	  else
	  	redirect_to edit_user_registration_path(@user), :alert => "Make sure you've correctly filled out all fields"
	  end
end

end