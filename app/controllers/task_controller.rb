class TaskController < ApplicationController
  def index
    user = User.find_by(:user_id => params[:user_id])
    @all_tasks = Task.all
    if user.is_submit
      @my_pending_tasks, @my_proceeding_tasks = Task.get_submit_tasks(user.user_id)
    elsif user.is_eval
      @my_pending_tasks, @my_done_tasks = Task.get_eval_tasks(user.user_id)
    end
  end

  def show
    return if not admin_check
    # redirect_to :action => 'index'
    @all_tasks = Task.all
    respond_to do |format|
      format.html
      format.xml  { render :xml => @posts }
    end
  end

  def new
    return if not admin_check
  	@task = Task.new
  end

  def create
    return if not admin_check
	  @task = Task.new(task_params)
    if @task.save!
      redirect_to :controller => 'original_data_type', :action => 'new', :task_id => @task.task_id
      #redirect_to :action => 'show'
    else
      flash[:warning] = "something's wrong! please check the input format again."
      redirect_to :action => 'new'
    end
  end

  def edit
  end

  def stop
    return if not admin_check
    @task = Task.find(params[:task_id])
    @task.update(:active => !@task.active)
    redirect_to :action => 'show'
  end


  def destroy
    return if not admin_check
    @task = Task.find(params[:id])
   
    @participates = Participate.where(task_id: @task.task_id)
    @participates.each do |p|
      p.destroy
    end
   
    @task.destroy
    respond_to do |format|
      #format.html { redirect_to task_url, notice: 'Task was successfully destroyed.' }
      format.html { redirect_to task_url }
      #format.json { head :no_content }
    end
  end

  private
    def task_params
      json_builder = "{\""
      json_builder += params[:task][:name0].to_s
      json_builder += "\" : \""
      json_builder += params[:task][:type0].to_s

      for i in 1..5
        sym_name = "name" + i.to_s # sym_name.to_sym is :name[i]
        sym_type = "type" + i.to_s # sym_type.to_sym is :type[i]

        if not params[:task][sym_name.to_sym].to_s == ""
          json_builder += "\", \""
          json_builder += params[:task][sym_name.to_sym].to_s
          json_builder += "\" : \""
          json_builder += params[:task][sym_type.to_sym].to_s
        end
      end

      json_builder += "\"}"

      params[:task][:tdt_schema_info] = json_builder.to_s
      
      params.require(:task)
      .permit(:task_name, :description, :min_upload_period_hour, :tdt_name, :tdt_schema_info)
    end
end
