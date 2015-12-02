require 'json'
require 'csv'
class OriginalDataFile < ActiveRecord::Base
	belongs_to :binary

	def self.upload_odf(data_io, odt_id)
	  print 'uploading....'
	  is_uploaded = false
	  odt = OriginalDataType.find_by(:odt_id => odt_id)
	  odf_raw = File.readlines(data_io.tempfile)
	  header = odf_raw[0]
	  is_header_valid, header_items = get_task_header(odt, header)
	  if odt != nil && is_header_valid
		pdsf_content, pdsf_summaries = save_task_items(odt, odf_raw[1...odf_raw.length], header_items)
		odf_content = odf_raw.join('').unpack('b*')[0]
		is_uploaded = save_infos(odt.odt_id, odf_content, pdsf_content, pdsf_summaries)
		# TODO : assign eval user
	  end
	  return is_uploaded
	end

	private
	  def self.get_task_header(odt, header)
	  	odt_schema_keys = JSON.parse(odt.schema_info).keys
	  	odt_mapping = JSON.parse(odt.mapping_info)
	  	header_items = CSV.parse(header)
	  	mapped = Hash.new
	  	# check if each header item is valid
	  	header_items[0].each do |item|
	  	  if !(odt_schema_keys.include?(item) && mapped[odt_mapping[item]] == nil)
	  	  	return false, []
	  	  end
	  	  mapped[odt_mapping[item]] = true
	  	end
	  	return true
	  end


	# TODO : calculate dup_tuple_num
	  def self.save_task_items(odt, odf_raw, header_items)
	  	pdsf_summaries = Hash["null_num" => 0, "total_tuple_num" => 0, "dup_tuple_num" => 0]
	  	pdsf_raw = []
	  	pdsf_raw << header
	  	odf_raw.each do |line|
	  	  task_item = TaskItem.save_item(line, header_items)
	  	  pdsf_summaries["null_num"] += 1 if is_null_line(line)
	  	  pdsf_summaries["dup_tuple_num"] += 1 if is_dup_line(line)
	  	  pdsf_summaries["total_tuple_num"] += 1
	  	  pdsf_raw << line
	  	end
	  	pdsf_content = pdsf_raw.join('').unpack('b*')[0]
	  	return pdsf_content, pdsf_summaries
	  end

	  def self.save_infos(odt_id, odf_content, pdsf_content, pdsf_summaries)
	    odf = OriginalDataFile.new(:file => odf_content)
	    pdsf_null_ratio = pdsf_summaries["null_num"] / pdsf_summaries["total_tuple_num"]
	    pdsf = ParsingDataSequenceFile.new(:file => pdsf_content,
	    	:null_ratio => pdsf_null_ratio,
	    	:total_tuple_num => pdsf_summaries["total_tuple_num"],
	    	:dup_tuple_num => pdsf_summaries["dup_tuple_num"])
	    if odf.save && pdsf.save
	      implement_odt = ImplementOdt.new(:odt_id => odt_id, :odf_id => odf.odf_id)
	  	  convert = Convert.new(:odf_id => odf.odf_id, :pdsf_id => pdsf.pdsf_id)
	  	  return implement_odt.save && convert.save
	    else
	  	  return false
	    end
	  end

	  def self.is_null_line(line)
	  	return line == ''
	  end

	  def self.is_dup_line(line)
	  	# TODO
	  	return false
	  end
end
