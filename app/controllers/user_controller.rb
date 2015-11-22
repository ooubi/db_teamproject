class UserController < ApplicationController
  def new
    @user = User.new
  end

  def show
    @user = User.find_by(:login_id => current_user.login_id)
    if @user.is_admin


      @all_users = User.all

      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @user }
      end
    else
      flash[:warning] = "login as administrator!!"
      redirect_to '/admin'
    end
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

  def edit
    @edit_user = User.find_by(:login_id => current_user.login_id)
  end

  def destroy
    @destroy_user = User.find_by(:login_id => current_user.login_id)
    if @destroy_user.destroy
      flash[:notice] = "Bye~"
      redirect_to '/login'
    else
      flash[:warning] = "Error."
    end
  end

  def update
    if User.update_user(user_params)
      flash[:notice] = "Successfully updated!"
      redirect_to :action => 'edit'
    else
      flash[:warning] = "Try again."
      redirect_to :action => 'edit'
    end
  end

  private
    def user_params
      if params[:user][:user_type] == 'admin'
        params[:user][:is_admin] = true
      elsif params[:user][:user_type] == 'eval'
        params[:user][:is_eval] = true
      elsif params[:user][:user_type] == 'submit'
        params[:user][:is_submit] = true
      end
      params.require(:user)
      .permit(:user_id, :login_id, :password, :name, :sex, :address, :birthdate, :cellphone, :is_admin, :is_eval, :is_submit)
    end
end