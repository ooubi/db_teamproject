class OriginalDataTypeController < ApplicationController
  def index
  end

  def show
    return if not admin_check
    @task = Task.find_by(task_id: params[:task_id])
    @odts = OriginalDataType.get_task_odts(params[:task_id])
  end

  def new
    return if not admin_check
    @original_data_type = OriginalDataType.new
    @task = Task.find_by(task_id: params[:task_id]) 
  end

  def create
    return if not admin_check
    original_data_type = OriginalDataType.new(original_data_type_params)
    if original_data_type.save!
      specify = Specify.new(:odt_id => original_data_type.odt_id, :task_id => params[:original_data_type][:task_id])
      if specify.save!
        redirect_to url_for(:controller => :task, :action => :show)
        return
      end
    end
    flash[:warning] = "something's wrong! please check the input format again."
    redirect_to :action => 'new'
  end

  private
    def original_data_type_params
      params.require(:original_data_type)
      .permit(:odt_id, :schema_info, :mapping_info)
    end

end  
