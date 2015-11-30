require 'rubygems'
require 'composite_primary_keys'
class Evaluate < ActiveRecord::Base
  self.primary_keys = :eval_user_id, :pdsf_id
end
