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

    def self.get_header_items_from_pdsf(pdsf_id)
    convert = Convert.find_by(:pdsf_id => pdsf_id)
    unless convert.nil?
      impl_odt = ImplementOdt.find_by(:odf_id => convert.odf_id)
      unless impl_odt.nil?
        specify = Specify.find_by(:odt_id => impl_odt.odt_id)
        unless specify.nil?
          task = Task.find_by(:task_id => specify.task_id)
          unless task.nil?
            return JSON.parse(task.tdt_schema_info).keys
          end
        end
      end
    end
    return []
  end
end
