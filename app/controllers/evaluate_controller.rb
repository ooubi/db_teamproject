class EvaluateController < ApplicationController
  def index
    @my_pending_pdsfs = Evaluate.get_pending_pdsfs(params[:user_id])
    @my_done_pdsfs = Evaluate.get_done_pdsfs(params[:user_id])
  end

  def edit
    eval_params = params[:evaluate]
    user_id, user_name = ParsingDataSequenceFile.get_user_infos(eval_params[:pdsf_id])
  	if eval_params[:pass_or_nonpass] == 'Pass'
  	  if ParsingDataSequenceFile.insert_eval_infos(eval_params[:pdsf_id], eval_params[:score], true) &&
          TaskItem.add_pdsf_items(user_id, user_name, eval_params[:pdsf_id]) &&
          User.update_score(user_id, true)
  	  	save_done(eval_params[:pdsf_id])
  	  else
  	  	flash[:warning] = "Something's wrong! Please try again."
  	  	redirect_to :action => 'index', :user_id => current_user.user_id
  	  end
  	else
      if ParsingDataSequenceFile.insert_eval_infos(eval_params[:pdsf_id], eval_params[:score], false) &&
          User.update_score(user_id, false)
  	    save_done(eval_params[:pdsf_id])
      else
        flash[:warning] = "Something's wrong! Please try again."
        redirect_to :action => 'index', :user_id => current_user.user_id
      end
  	end
  end

  private
    def save_done(pdsf_id)
      is_saved = Evaluate.set_pending_to_done(pdsf_id)
  	  if is_saved
  	    flash[:notice] = "Successfully evaluated!"
  	  else
  	    flash[:warning] = "Something's wrong! Please try again."
  	  end
  	  redirect_to :action => 'index', :user_id => current_user.user_id
    end
end
