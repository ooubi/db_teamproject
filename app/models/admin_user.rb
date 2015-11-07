class AdminUser < ActiveRecord::Base
  def self.add_user(uid)
  	new_user = new(:user_id => uid)
  	if !new_user.save then return false end
  	return true
  end
end
