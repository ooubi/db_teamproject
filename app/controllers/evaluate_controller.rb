class EvaluateController < ApplicationController
  def index
    @my_pending_pdsfs = Evaluate.get_pending_pdsfs(current_user.user_id)
    @my_done_pdsfs = Evaluate.get_done_pdsfs(current_user.user_id)
  end
end
