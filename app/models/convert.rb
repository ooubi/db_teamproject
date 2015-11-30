require 'rubygems'
require 'composite_primary_keys'
class Convert < ActiveRecord::Base
  self.primary_keys = :odf_id, :pdsf_id
end
