class Task < ActiveRecord::Base
  validates_numericality_of :min_upload_period_hour, inclusion: { :greater_than_or_equal_to => 1, :message => "min upload period hour should be more than 1 hour" }

  def self.get_submit_tasks(uid)
  	tasks = []
    participates = Participate.where(:submit_user_id => uid)
  	if participates != nil
  	  for participate in participates
  	    tasks << find_by(:task_id => participate.task_id)
  	  end
  	end
  	return tasks
  end

  def self.get_eval_tasks(uid)
  	tasks = []
  	evaluates = Evaluate.where(:eval_user_id => uid, :is_pending => true)
  	if evaluates != nil
  	  for evaluate in evaluates
  	    tasks << find_by(:task_id => evaluate.task_id)
  	  end
  	end
  	return tasks
  end
end

# TODO : create parsing data sequence type when created