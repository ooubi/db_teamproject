class Convert < ActiveRecord::Base
  self.primary_keys = :odf_id, :pdsf_id
end
