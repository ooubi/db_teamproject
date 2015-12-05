class AdminSessionController < ApplicationController
  def new
  end

  def index
    if current_user != nil && current_user.is_admin()
      redirect_to '/admin/home'
    else
      redirect_to '/admin/login'
    end
  end

  def create
  	user = User.find_by(login_id: params[:session][:login_id])
    if user && user.auth(params[:session][:password]) && user.is_admin()
      log_in user
      redirect_to '/admin/home'
    else
      flash[:warning] = "something's wrong! please log in again."
      redirect_to '/admin'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
