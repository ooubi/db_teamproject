class OriginalDataTypeController < ApplicationController
  def index
    @task = Task.find_by(:task_id => params[:task_id])
    @odts = OriginalDataType.get_task_odts(params[:task_id])
    @my_pdsf_num = 0
    @tuple_num = 0
    submit = Submit.where(:user_id => current_user.user_id)
    implement_task = ImplementTask.where(:task_id => params[:task_id])
    if submit != nil
      @my_pdsf_num = submit.size
    end    
    if implement_task != nil
      @tuple_num = implement_task.size
    end
  end

  def show
    return if not admin_check
    @task = Task.find_by(task_id: params[:task_id])
    @odts = OriginalDataType.get_task_odts(params[:task_id])
    @pdsf_num = 0
    @tuple_num = 0
    specifies = Specify.where(:task_id => params[:task_id])
    implement_task = ImplementTask.where(:task_id => params[:task_id])
    # Count pdsf nums
    if specifies != nil
      specifies.each do |specify|
        implement_odts = ImplementOdt.where(:odt_id => specify.odt_id)
        if implement_odts != nil
          @pdsf_num += implement_odts.size
        end
      end
    end
    # Count tuple nums
    if implement_task != nil
      @tuple_num = implement_task.size
    end
  end

  def new
    return if not admin_check
    @original_data_type = OriginalDataType.new
    @task = Task.find_by(task_id: params[:task_id]) 
  end

  def create
    return if not admin_check
    odt = OriginalDataType.new(original_data_type_params)
    if odt.save!
      specify = Specify.new(:odt_id => odt.odt_id, :task_id => params[:original_data_type][:task_id])
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
      json_builder = "{\""
      json_builder += params[:original_data_type][:name0].to_s
      json_builder += "\" : \""
      json_builder += params[:original_data_type][:type0].to_s

      for i in 1..5
        sym_name = "name" + i.to_s # sym_name.to_sym is :name[i]
        sym_type = "type" + i.to_s # sym_type.to_sym is :type[i]

        if not params[:original_data_type][sym_name.to_sym].to_s == ""
          json_builder += "\", \""
          json_builder += params[:original_data_type][sym_name.to_sym].to_s
          json_builder += "\" : \""
          json_builder += params[:original_data_type][sym_type.to_sym].to_s
        end
      end
      json_builder += "\"}"
      params[:original_data_type][:schema_info] = json_builder.to_s


      json_builder = "{\""
      json_builder += params[:original_data_type][:from0].to_s
      json_builder += "\" : \""
      json_builder += params[:original_data_type][:to0].to_s

      for i in 1..5
        sym_name = "from" + i.to_s # sym_name.to_sym is :name[i]
        sym_type = "to" + i.to_s # sym_type.to_sym is :type[i]

        if not params[:original_data_type][sym_name.to_sym].to_s == ""
          json_builder += "\", \""
          json_builder += params[:original_data_type][sym_name.to_sym].to_s
          json_builder += "\" : \""
          json_builder += params[:original_data_type][sym_type.to_sym].to_s
        end
      end
      json_builder += "\"}"
      params[:original_data_type][:mapping_info] = json_builder.to_s

      params.require(:original_data_type)
      .permit(:odt_id, :odt_name, :schema_info, :mapping_info)
    end

end  
