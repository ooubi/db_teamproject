require 'rubygems'
require 'composite_primary_keys'
class Evaluate < ActiveRecord::Base
  self.primary_keys = :eval_user_id, :pdsf_id

  def self.assign_if_possible()
  	pdsf = ParsingDataSequenceFile.where(:is_assigned => false).first
  	if pdsf != nil
  	  users = User.where(:is_eval => true)
  	  users.each do |user|
  	  	eval_user = EvalUser.find_by(:user_id => user.user_id, :on_process => false)
  	  	if eval_user != nil
  	  	  evaluate = Evaluate.new(:eval_user_id => eval_user.user_id,
  	  		:pdsf_id => pdsf.pdsf_id)
  	  	  if evaluate.save!
  	  	    pdsf.is_assigned = true
  	  	    eval_user.on_process = true
  	  	    return pdsf.save! && eval_user.save!
  	  	  end
  	  	end
  	  end
  	end
  	return false
  end

  def self.get_pending_pdsfs(uid)
  	pdsfs = []
  	pendings = where(:eval_user_id => uid, :is_pending => true)
  	if pendings != nil
  	  pendings.each do |pending|
  	  	pdsfs << ParsingDataSequenceFile.find_by(:pdsf_id => pending.pdsf_id)
  	  end
  	end
  	return pdsfs
  end

  def self.get_done_pdsfs(uid)
  	pdsfs = []
  	dones = where(:eval_user_id => uid, :is_pending => false)
  	if dones != nil
  	  dones.each do |done|
  	  	pdsfs << ParsingDataSequenceFile.find_by(:pdsf_id => done.pdsf_id)
  	  end
  	end
  	return pdsfs
  end
end
