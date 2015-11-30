require 'rubygems'
require 'composite_primary_keys'
class ImplementOdt < ActiveRecord::Base
  self.primary_keys = :odt_id, :odf_id
end
