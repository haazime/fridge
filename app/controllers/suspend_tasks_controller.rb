class SuspendTasksController < ApplicationController
  def create
    @issue_id = Issue::Id.from_string(params[:issue_id])
    SuspendTaskUsecase.perform(@issue_id, params[:number].to_i)
    @tasks = TaskListQuery.call(@issue_id.to_s)

    render :update_task
  end
end