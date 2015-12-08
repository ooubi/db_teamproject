class ParsingDataSequenceFileController < ApplicationController
  def index
  	#header = OriginalDataType.get_pdsf_header_items(params[:pdsf_id])
  	header = Task.get_header_items_from_pdsf(params[:pdsf_id])
  	rows = ParsingDataSequenceFile.get_rows(params[:pdsf_id])
  	datas = header.join(',') + "\n" + rows.join("\n")
    send_data( datas, :filename => params[:pdsf_id].to_s + ".csv" )
  end
end
