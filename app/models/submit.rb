require 'rubygems'
require 'composite_primary_keys'
class Submit < ActiveRecord::Base
  self.primary_keys = :submit_user_id, :odf_id
end
