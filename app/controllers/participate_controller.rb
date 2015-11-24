class ParticipateController < ApplicationController
  def index
  end

  def show
    return if not admin_check
	@task_id = params[:task_id]
	@pending_users = Participate.get_pending_users(@task_id)
	@permitted_users = Participate.get_permitted_users(@task_id)
  end

  def new
  end

  def update
    return if not admin_check
    if Participate.update_user_state(params[:task_id], params[:user_id], params[:user_state])
	  flash[:notice] = "Successfully updated!"      
    else
	  flash[:notice] = "Something's wrong! Please try again."      	
    end
	redirect_to :action => 'index'
  end
end
