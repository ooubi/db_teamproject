class OriginalDataType < ActiveRecord::Base
  def self.get_task_odts(tid)
  	odts = []
    specifies = Specify.where(task_id: tid)
    if specifies != nil
      for specify in specifies
        odts << find_by(:odt_id => specify.odt_id)
      end
    end
    return odts
  end
end
