require 'json'
require 'csv'
class OriginalDataFile < ActiveRecord::Base
	belongs_to :binary

	def self.upload_odf(data_io, odt_id, user_id, task_id, season_info, period_info)
	  print 'uploading....'
	  is_uploaded = false
	  odt = OriginalDataType.find_by(:odt_id => odt_id)
	  odf_raw = File.readlines(data_io.tempfile)
	  header = odf_raw[0]
	  if odt != nil
	  	is_uploaded = upload_datas(task_id, user_id, season_info, period_info, odt, header, odf_raw)
	  end
	  if is_uploaded
		Evaluate.assign_if_possible
	  end
	  return is_uploaded
	end

	private
	  def self.upload_datas(task_id, user_id, season_info, period_info, odt, header, odf_raw)
	  	odt_schema_keys = JSON.parse(odt.schema_info).keys
	  	odt_mapping = JSON.parse(odt.mapping_info)
	  	header_items = CSV.parse(header)[0]
	  	if is_header_valid(odt, header, odt_schema_keys, odt_mapping, header_items)
	  	  task_header_items = Task.get_header_items(task_id)
		  pdsf_content, pdsf_summaries = save_task_items(
		  	task_id, odt, odf_raw[1...odf_raw.length], odt_mapping, header_items, task_header_items)
		  odf_content = odf_raw.join('').unpack('b*')[0]
		  return save_infos(odt.odt_id, user_id, season_info, period_info, odf_content, pdsf_content, pdsf_summaries)
		end
		return false
	  end

	  def self.is_header_valid(odt, header, odt_schema_keys, odt_mapping, header_items)
	  	mapped = Hash.new
	  	header_items.each do |item|
	  	  if odt_mapping[item] != nil && mapped[odt_mapping[item]] != nil
	  	  	return false
	  	  end
	  	  mapped[odt_mapping[item]] = true
	  	end
	  	return true
	  end

	# TODO : calculate dup_tuple_num
	  def self.save_task_items(task_id, odt, odf_raw, odt_mapping, odt_header_items, task_header_items)
	  	pdsf_summaries = Hash["null_num" => 0, "total_tuple_num" => 0, "dup_tuple_num" => 0]
	  	pdsf_raw = []
	  	pdsf_raw << task_header_items.join(',')
	  	odf_raw.each do |line|
	  	  parsed_line, pdsf_summaries = get_pdsf_info(
	  	  	line, pdsf_summaries, odt_mapping, odt_header_items, task_header_items)
	  	  if parsed_line != nil
	  	    pdsf_raw << parsed_line
	  	  end
	  	end
	  	pdsf_content = pdsf_raw.join('\n').unpack('b*')[0]
	  	return pdsf_content, pdsf_summaries
	  end

      # TODO : is pdsf_summaries ok?? double add ?
	  def self.get_pdsf_info(line, pdsf_summaries, odt_mapping, odt_header_items, task_header_items)
	  	is_null = is_null_line(line)
	  	is_dup = is_dup_line(line)
	  	pdsf_summaries["null_num"] += 1 if is_null
	  	pdsf_summaries["dup_tuple_num"] += 1 if is_dup
	  	pdsf_summaries["total_tuple_num"] += 1
	  	if is_null || is_dup
	  	  return nil, pdsf_summaries
	  	else
	  	  return get_parsed_line(line, odt_mapping, odt_header_items, task_header_items), pdsf_summaries
	  	end
	  end

	  def self.get_parsed_line(line, odt_mapping, odt_header_items, task_header_items)
	  	raw_items = line.split(',')
	  	parsed_items = []
	  	task_header_items.each do |item|
	  	  odt_index = odt_header_items.index(odt_mapping[item])
	  	  parsed_items << raw_items[odt_index]
	  	end
	  	return parsed_items.join(',')
	  end

	  def self.save_infos(odt_id, user_id, season_info, period_info, odf_content, pdsf_content, pdsf_summaries)
	    odf = OriginalDataFile.new(:file => odf_content)
	    pdsf_null_ratio = pdsf_summaries["null_num"] / pdsf_summaries["total_tuple_num"]
	    pdsf = ParsingDataSequenceFile.new(:file => pdsf_content,
	    	:null_ratio => pdsf_null_ratio,
	    	:season_info => season_info,
	    	:period_info => period_info,
	    	:total_tuple_num => pdsf_summaries["total_tuple_num"],
	    	:dup_tuple_num => pdsf_summaries["dup_tuple_num"])
	    if odf.save && pdsf.save
	      submit = Submit.new(:user_id => user_id, :odf_id => odf.odf_id)
	      implement_odt = ImplementOdt.new(:odt_id => odt_id, :odf_id => odf.odf_id)
	  	  convert = Convert.new(:odf_id => odf.odf_id, :pdsf_id => pdsf.pdsf_id)
	  	  return submit.save && implement_odt.save && convert.save
	    else
	  	  return false
	    end
	  end

	  def self.is_null_line(line)
	  	return line == ''
	  end

	  def self.is_dup_line(line)
	  	return false
	  end
end
