class ParticipateController < ApplicationController
  def index
	@task_id = params[:task_id]
	@pending_users = []
	@permitted_users = []
  	pendings = Participate.find_by(:task_id => params[:task_id], :is_pending => true)
	permitteds = Participate.find_by(:task_id => params[:task_id], :is_permitted => true)
	if pendings != nil
	  for pending in pendings
		@pending_users << User.find_by(pending.submit_user_id)
	  end
	end
	if permitteds != nil
	  for permitted in permitteds
		@permitted_users << User.find_by(pending.submit_user_id)
	  end
	end
  end

  def update
  	participate = Participate.find_by(:task_id => params[:task_id], :submit_user_id => params[:user_id])
  	if params[:user_state] == "permitted" && participate.update_attributes(:is_pending => false, :is_permitted => true)
      flash[:notice] = "Successfully updated!"      
  	elsif params[:user_state] == "declined" && participate.update_attributes(:is_pending => false, :is_permitted => false)
      flash[:notice] = "Successfully updated!"      
    else
      flash[:notice] = "Something's wrong! Please try again."      
    end
    redirect_to :action => 'index'
  end
end
