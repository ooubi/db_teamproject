class OriginalDataType < ActiveRecord::Base

  #attr_accessor :name0, :name1, :name2, :name3, :name4, :name5, :type0, :type1, :type2, :type3, :type4, :type5, :from0, :from1, :from2, :from3, :from4, :from5, :to0, :to1, :to2, :to3, :to4, :to5

  def self.set_attr_accessor(attr_num, map_num)
    for i in 0..attr_num
      self.class_eval { attr_accessor "name" + i.to_s }
      self.class_eval { attr_accessor "type" + i.to_s }
    end
    for i in 0..map_num
      self.class_eval { attr_accessor "from" + i.to_s }
      self.class_eval { attr_accessor "to" + i.to_s }      
    end
  end

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

  def self.get_pdsf_header_items(pdsf_id)
    convert = Convert.find_by(:pdsf_id => pdsf_id)
    unless convert.nil?
      impl_odt = ImplementOdt.find_by(:odf_id => convert.odf_id)
      unless impl_odt.nil?
        schema_info = find_by(:odt_id => impl_odt.odt_id).schema_info
        return JSON.parse(schema_info).keys
      end
    end
    return []
  end
end
