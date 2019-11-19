class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    if params[:name].blank? && params[:status].blank?
      @tasks = Task.all
      if params[:sort_expired].blank?
        @tasks = @tasks.order(created_at: :desc)
      else
        @tasks = @tasks.order(expired_at: :desc)
      end
    elsif params[:name].blank?
      @tasks = Task.where("status LIKE ?", "%#{ params[:status] }%")
    elsif params[:status].blank?
      @tasks = Task.where("name LIKE ?", "%#{ params[:name] }%")
    else
      @tasks = Task.where("status LIKE ?", "%#{ params[:status] }%").where("name LIKE ?", "%#{ params[:name] }%")
    end
    
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.create(task_params)
    if @task.save
      redirect_to task_path(@task.id), notice: "タスクを作成しました！"
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to task_path(@task.id), notice: "タスクを編集しました！"
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: "タスクを削除しました！"
  end

  private

  def task_params
    params.require(:task).permit(:name, :detail, :expired_at, :status, :search)
  end

  def set_task
    @task = Task.find(params[:id])
  end
end
