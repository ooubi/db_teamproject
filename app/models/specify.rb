class Specify < ActiveRecord::Base
  self.primary_keys = :odt_id, :task_id
end
