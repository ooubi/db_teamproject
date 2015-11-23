class OriginalDataTypeController < ApplicationController
  def new
  	@original_data_type = OriginalDataType.new
  	@task = Task.find_by(task_id: params[:task_id])      
  end

  def create
  	@original_data_type = OriginalDataType.new(original_data_type_params)
    if @original_data_type.save!
      submit = Submit.new(:odt_id => @original_data_type.odt_id, :task_id => params[:original_data_type][:task_id])
      if submit.save!
        redirect_to url_for(:controller => :task, :action => :index)
      else
        flash[:warning] = "something's wrong! please check the input format again."
        redirect_to :action => 'new'
      end
    else
      flash[:warning] = "something's wrong! please check the input format again."
      redirect_to :action => 'new'
    end
  end

  private
    def original_data_type_params
      params.require(:original_data_type)
      .permit(:odt_id, :schema_info, :mapping_info, :pdst_id)
    end

end  
