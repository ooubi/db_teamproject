require 'rubygems'
require 'composite_primary_keys'
class Evaluate < ActiveRecord::Base
  self.primary_keys = :user_id, :pdsf_id

  def self.assign_if_possible()
  	pdsf = ParsingDataSequenceFile.where(:is_assigned => false).first
  	if pdsf != nil
  	  users = User.where(:is_eval => true)
  	  users.each do |user|
  	  	eval_users = EvalUser.where(:user_id => user.user_id)
  	  	if eval_users != nil
          eval_user = eval_users[rand(0...eval_users.size)]
  	  	  evaluate = Evaluate.new(:user_id => eval_user.user_id,
  	  		:pdsf_id => pdsf.pdsf_id)
  	  	  if evaluate.save!
  	  	    pdsf.is_assigned = true
  	  	    return pdsf.save! && eval_user.save!
  	  	  end
  	  	end
  	  end
  	end
  	return false
  end

  def self.set_pending_to_done(pdsf_id)
    evaluate = Evaluate.find_by(:pdsf_id => pdsf_id)
    if evaluate != nil
      return evaluate.update_attributes(:is_pending => false)
    end
    return false
  end

  def self.get_pending_pdsfs(uid)
  	pdsfs = []
  	pendings = where(:user_id => uid, :is_pending => true)
  	if pendings != nil
  	  pendings.each do |pending|
  	  	pdsfs << ParsingDataSequenceFile.find_by(:pdsf_id => pending.pdsf_id)
  	  end
  	end
  	return pdsfs
  end

  def self.get_done_pdsfs(uid)
  	pdsfs = []
  	dones = where(:user_id => uid, :is_pending => false)
  	if dones != nil
  	  dones.each do |done|
  	  	pdsfs << ParsingDataSequenceFile.find_by(:pdsf_id => done.pdsf_id)
  	  end
  	end
  	return pdsfs
  end
end
