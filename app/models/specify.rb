require 'rubygems'
require 'composite_primary_keys'
class Specify < ActiveRecord::Base
  self.primary_keys = :odt_id, :task_id
end
