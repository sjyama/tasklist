class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
 
  def index
    @tasks = Task.all
  end

  def show
    #@task = Task.find(params[:id])
  end

  def new
    @task = Task.new
    #@task = Task.new(content: 'input-task')
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      flash[:success] = 'タスク追加：正常終了'
      redirect_to @task
      #redirect_to tasks_url
    else
      flash.now[:danger] = 'タスク追加：異常終了'
      render :new
    end
  end

  def edit
    #@task = Task.find(params[:id])
  end

  def update
    #@task = Task.find(params[:id])
    if @task.update(task_params)
      flash[:success] = 'タスク更新：正常終了'
      redirect_to @task
      #redirect_to tasks_url
    else
      flash.now[:danger] = 'タスク更新：異常終了'
      render :edit
    end
  end

  def destroy
    #@task = Task.find(params[:id])
    @task.destroy
    flash[:success] = 'タスク削除：正常終了'
    redirect_to tasks_url
  end
end #このendの位置も誤りでしょうか？？

private
def set_task
  @task = Task.find(params[:id])
end

#Strong Parameter
def task_params
  params.require(:task).permit(:content, :status)
end