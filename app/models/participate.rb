require 'rubygems'
require 'composite_primary_keys'
class Participate < ActiveRecord::Base
  self.primary_keys = :user_id, :task_id

  def self.destroy_user(uid)
    participates = where(:user_id => uid)
    unless participates.nil?
      participates.each do |p|
        p.destroy
      end
    end
  end

  def self.destroy_task(tid)
    participates = where(:task_id => tid)
    unless participates.nil?
      participates.each do |p|
        
        p.destroy # TODO : is this enough? what about eval?
      end
    end
  end

  def self.get_pending_users(tid)
    pending_users = []
    pendings = where(:task_id => tid, :is_pending => true)
    if pendings != nil
	  for pending in pendings
		pending_users << User.find_by(:user_id => pending.user_id)
	  end
	end
	return pending_users
  end

  def self.get_permitted_users(tid)
	permitted_users = []
  	permitteds = where(:task_id => tid, :is_pending => false, :is_permitted => true)
	if permitteds != nil
	  for permitted in permitteds
	    permitted_users << User.find_by(:user_id => permitted.user_id)
	  end
	end
	return permitted_users
  end

  def self.get_pending_tasks(uid)
  	tasks = []
  	pendings = where(:user_id => uid, :is_pending => true)
  	if pendings != nil
  	  pendings.each do |pending|
  	  	tasks << Task.find_by(:task_id => pending.task_id)
  	  end
  	end
  	return tasks
  end

  def self.get_permitted_tasks(uid)
  	tasks = []
  	permitteds = where(:user_id => uid, :is_pending => false, :is_permitted => true)
  	if permitteds != nil
  	  permitteds.each do |permitted|
  	  	tasks << Task.find_by(:task_id => permitted.task_id)
  	  end
  	end
  	return tasks
  end
    
  def self.update_user_state(tid, uid, us)
	participate = find_by(:task_id => tid, :user_id => uid)
  is_permitted = (us == "permitted" && participate.update_attributes(:is_pending => false, :is_permitted => true))
	#is_declined = (us == "declined" && participate.update_attributes(:is_pending => false, :is_permitted => false))
  is_declined = (us == "declined" && participate.destroy)
  return is_permitted || is_declined
  end

  def self.join(cu, tid)
  	participate = new(:user_id => cu.user_id, :task_id => tid)
  	return participate.save
  end
end
