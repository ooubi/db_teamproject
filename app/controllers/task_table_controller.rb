class TaskTableController < ApplicationController
  def show
  	header = Task.get_header_items(params[:task_id])
  	rows = TaskTable.get_tuple_rows(params[:task_id])
  	datas = header.join(',') + "\n" + rows.join("\n")
    send_data( datas, :filename => params[:task_id].to_s + ".csv" )
  end
end
