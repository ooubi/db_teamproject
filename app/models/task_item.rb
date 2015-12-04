class TaskItem < ActiveRecord::Base
  def self.add_pdsf_items(user_id, user_name, pdsf_id)
  	task_id = ParsingDataSequenceFile.get_task_id(pdsf_id)
  	rows = ParsingDataSequenceFile.get_rows(pdsf_id)
  	unless user_id.nil? || user_name.nil? || task_id.nil? || rows.nil?
  	  return add_items(user_id, user_name, task_id, pdsf_id, rows)
  	else
  	  return false
  	end
  end

  def self.get_tuple_rows(tid)
  	rows = []
  	impl_tasks = ImplementTask.where(:task_id => tid)
  	unless impl_tasks.nil?
  	  impl_tasks.each do |impl_task|
  	    task_item = find_by(:task_item_id => impl_task.task_item_id)
  	    unless task_item.nil?
  	      rows << task_item.item
  	    end
  	  end
  	end
  	return rows
  end

  private
	def self.add_items(user_id, user_name, task_id, pdsf_id, rows)
	  rows.each do |row|
	  	if !add_item(user_id, user_name, task_id, pdsf_id, row)
	  	  return false
	  	end
	  end
	  return true
	end

	def self.add_item(user_id, user_name, task_id, pdsf_id, row)
	  task_item = TaskItem.new(:user_id => user_id, :user_name => user_name, :item => row)
	  if !task_item.save!
	    return false
	  else
	    implement_task = ImplementTask.new(:task_id => task_id,
	    	:task_item_id => task_item.task_item_id, :pdsf_id => pdsf_id)
	    return implement_task.save!
	  end
	end

end
