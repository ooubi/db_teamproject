class Task < ActiveRecord::Base
  validates_numericality_of :min_upload_period_hour, inclusion: { :greater_than_or_equal_to => 1, :message => "min upload period hour should be more than 1 hour" }

  def self.get_submit_tasks(uid)
  	tasks = []
  	submits = Submit.where(:submit_user_id => uid)
  	if submits != nil
  	  for submit in submits
  	    tasks << find_by(:task_id => submit.task_id)
  	  end
  	end
  	return tasks
  end

  def self.get_eval_tasks(uid)
  	tasks = []
  	evals = Eval.where(:eval_user_id => uid, :is_pending => true)
  	if evals != nil
  	  for eval in evals
  	    tasks << find_by(:task_id => submit.task_id)
  	  end
  	end
  	return tasks
  end
end

# TODO : create parsing data sequence type when created