class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionHelper

  def admin_check
  	if current_user != nil and User.find_by(:login_id => current_user.login_id).is_admin
  	  return true
  	end
  	flash[:warning] = "login as administrator!!"
    redirect_to '/admin'  
    return false
  end
end