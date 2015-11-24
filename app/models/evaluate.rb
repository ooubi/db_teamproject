class Evaluate < ActiveRecord::Base
  self.primary_keys = :eval_user_id, :pdsf_id
end
