class Generalize < ActiveRecord::Base
  self.primary_keys = :odt_id, :pdst_id
end
