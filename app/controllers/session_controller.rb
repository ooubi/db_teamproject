class SessionController < ApplicationController
  def new
  end

  def create
  	user = User.find_by(login_id: params[:session][:login_id])
  	if user && user.auth(params[:session][:password])
  	  log_in user
  	  redirect_to root_url
  	else
      flash[:warning] = "something's wrong! please check the input format again."
      redirect_to :action => 'new'
  	end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
