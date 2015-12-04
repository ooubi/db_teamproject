require 'json'
class Task < ActiveRecord::Base
  validates_numericality_of :min_upload_period_hour, inclusion: { :greater_than_or_equal_to => 1, :message => "min upload period hour should be more than 1 hour" }

  attr_accessor :name0, :name1, :name2, :name3, :name4, :name5, :type0, :type1, :type2, :type3, :type4, :type5

  def self.get_submit_tasks(uid)
  	pending_tasks = []
    proceeding_tasks = []
    disabled_tasks = []
    participates = Participate.where(:user_id => uid)
  	if participates != nil
  	  for participate in participates
        if participate.is_pending
  	      pending_tasks << find_by(:task_id => participate.task_id)
        elsif participate.is_permitted
          proceeding_tasks << find_by(:task_id => participate.task_id)
        end
  	  end
  	end
  	return pending_tasks, proceeding_tasks, disabled_tasks
  end

  def self.get_eval_tasks(uid)
  	pending_tasks = []
    done_tasks = []
  	evaluates = Evaluate.where(:user_id => uid)
  	if evaluates != nil
  	  for evaluate in evaluates
        if evaluate.is_pending
  	      pending_tasks << find_by(:task_id => evaluate.task_id)
        else
          done_tasks << find_by(:task_id => evaluate.task_id)
        end
  	  end
  	end
  	return pending_tasks, done_tasks
  end

  def self.get_header_items(tid)
    schema_info = find_by(:task_id => tid).tdt_schema_info
    return JSON.parse(schema_info).keys
  end
end
