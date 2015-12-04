require 'rubygems'
require 'composite_primary_keys'
class ImplementOdt < ActiveRecord::Base
  self.primary_keys = :odt_id, :odf_id
  # TODO : order by!
  def self.get_pdsfs(odt_id)
  	pdsfs = []
  	impl_odts = where(:odt_id => odt_id)
  	unless impl_odts.nil?
  	  impl_odts.each do |impl_odt|
  	  	convert = Convert.find_by(:odf_id => impl_odt.odf_id)
  	  	unless convert.nil?
  	      pdsfs << ParsingDataSequenceFile.find_by(:pdsf_id => convert.pdsf_id)
  	    end
  	  end
  	end
  	pdsfs = pdsfs.sort_by {|pdsf| pdsf.season_info}
  	return pdsfs
  end

  def self.get_my_pdsfs(odt_id, user_id)
  	pdsfs = []
  	impl_odts = where(:odt_id => odt_id)
  	unless impl_odts.nil?
  	  impl_odts.each do |impl_odt|
  	  	submit = Submit.find_by(:user_id => user_id, :odf_id => impl_odt.odf_id)
  	  	unless submit.nil?
  	  	  convert = Convert.find_by(:odf_id => submit.odf_id)
  	  	  unless convert.nil?
  	        pdsfs << ParsingDataSequenceFile.find_by(:pdsf_id => convert.pdsf_id)
  	      end
  	    end
  	  end
  	end
  	pdsfs = pdsfs.sort_by {|pdsf| pdsf.season_info}
  	return pdsfs
  end
end
