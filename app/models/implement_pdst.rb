require 'rubygems'
require 'composite_primary_keys'
class ImplementPdst < ActiveRecord::Base
  self.primary_keys = :pdst_id, :pdsf_id
end
