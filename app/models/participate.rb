require 'rubygems'
require 'composite_primary_keys'
class Participate < ActiveRecord::Base
  self.primary_keys = :submit_user_id, :task_id # TODO : check!

  def self.get_pending_users(tid)
    pending_users = []
    pendings = where(:task_id => tid, :is_pending => true)
    if pendings != nil
	  for pending in pendings
		pending_users << User.find_by(pending.submit_user_id)
	  end
	end
	return pending_users
  end


  def self.get_permitted_users(tid)
	permitted_users = []
  	permitteds = where(:task_id => tid, :is_pending => false, :is_permitted => true)
	if permitteds != nil
	  for permitted in permitteds
	    permitted_users << User.find_by(permitted.submit_user_id)
	  end
	end
	return permitted_users
  end
    
  def self.update_user_state(tid, uid, us)
	participate = find_by(:task_id => tid, :submit_user_id => uid)
	is_permitted = (us == "permitted" && participate.update_attributes(:is_pending => false, :is_permitted => true))
	is_declined = (us == "declined" && participate.update_attributes(:is_pending => false, :is_permitted => false))
	return is_permitted || is_declined
  end

  def self.join(cu, tid)
  	participate = new(:submit_user_id => cu.user_id, :task_id => tid)
  	return participate.save
  end
end
