class TasksController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :new, :create]
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:show, :edit, :update, :destroy]
 
  def index
    #@tasks = Task.all.page(params[:page])
    @tasks = current_user.tasks.page(params[:page]).per(8)
    #@tasks = Task.all.page(params[:page]).per(8)
  end

  def show
    #@task = Task.find(params[:id])
  end

  def new
    @task = current_user.tasks.build #[build...newメソッドのAlias]
    #@task = Task.new(content: 'input-task') #[入力欄に初期値を表示させる場合]
    #@task = Task.new
  end

  def create
    @task = current_user.tasks.build(task_params)
    #@task = Task.new(task_params)
    if @task.save
      flash[:success] = 'タスク追加：正常終了'
      #redirect_to @task
      redirect_to tasks_url
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
      #redirect_to @task
      redirect_to tasks_url
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

  private
  
  def set_task
    @task = Task.find(params[:id])
  end

  #Strong Parameter
  def task_params
    #params.require(:task).permit(:content, :status)
    params.require(:task).permit(:content, :status, :user_id)
  end
  
  #ログインユーザー(current_user?)が、タスクのユーザーと一致しているか確認。
  def correct_user
    #current_userへの情報セットは、sessions_helperにて実施。
    redirect_to root_url if current_user != @task.user
  end
end