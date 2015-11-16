class TaskController < ApplicationController
  def index
  	@all_tasks = Task.get_all_tasks()
  end

  # TODO
  def show
  	if current_user.is_submit
  	elsif current_user.is_eval
  	end
  end
end
