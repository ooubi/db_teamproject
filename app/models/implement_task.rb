class ImplementTask < ActiveRecord::Base
  def self.get_odt_tuple_num(odt_id)
  	tuple_num = 0
  	impl_odts = ImplementOdt.where(:odt_id => odt_id)
  	unless impl_odts.nil?
  	  impl_odts.each do |impl_odt|
  	    convert = Convert.find_by(:odf_id => impl_odt.odf_id)
  	    unless convert.nil?
  	      tuple_num += where(:pdsf_id => convert.pdsf_id).size
  	    end
  	  end
  	end
  	return tuple_num
  end

end
