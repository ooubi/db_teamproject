class UserController < ApplicationController
  def show
    @user = User.find(params[:login_id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      redirect_to root_url
    else
      flash[:warning] = "something's wrong! please check the input format again."
      redirect_to :action => 'new'
    end
  end

  private
    def user_params
      params.require(:user)
      .permit(:name, :login_id, :password, :name, :sex, :address, :birthdate, :cellphone, :user_type)
    end
end