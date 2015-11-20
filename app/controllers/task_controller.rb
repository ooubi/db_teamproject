class TaskController < ApplicationController
  def index
  	@all_tasks = Task.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @posts }
    end
  
  end

  def show
    redirect_to :action => 'index'
  end

  def new
  	@task = Task.new
  end

  def create
	@task = Task.new(task_params)

    if @task.save!
      redirect_to :action => 'index'
    else
      flash[:warning] = "something's wrong! please check the input format again."
      redirect_to :action => 'new'
    end
  end

  def edit
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    respond_to do |format|
      format.html { redirect_to task_url, notice: 'Task was successfully destroyed.' }
      #format.json { head :no_content }
    end
  end



  
  # TODO
  '''def show
  	if current_user.is_submit
  	elsif current_user.is_eval
  	end
  end'''


  private
    def task_params
      params.require(:task)
      .permit(:task_name, :description, :min_upload_period_hour, :tdt_name, :tdt_schema_info)
    end
end
