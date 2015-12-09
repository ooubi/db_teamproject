class SubmitUser < ActiveRecord::Base
  def self.add_user(uid)
  	if find_by(:user_id => uid).nil?
  	  new_user = new(:user_id => uid)
  	  if !new_user.save then return false end
  	  return true
  	end
  end
end
