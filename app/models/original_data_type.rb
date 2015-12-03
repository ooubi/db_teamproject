class OriginalDataType < ActiveRecord::Base
  attr_accessor :name0, :name1, :name2, :name3, :name4, :name5, :type0, :type1, :type2, :type3, :type4, :type5, :from0, :from1, :from2, :from3, :from4, :from5, :to0, :to1, :to2, :to3, :to4, :to5

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
