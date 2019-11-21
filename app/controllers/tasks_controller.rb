class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  PER = 5

  def index
    if params[:name].blank? && params[:status].blank?
      @tasks = Task.page(params[:page]).per(PER)
      if params[:sort_expired].blank? && params[:sort_priority].blank?
        @tasks = @tasks.order(created_at: :desc)
      elsif params[:sort_expired].blank?
        @tasks = @tasks.order(priority: :asc)
      else
        @tasks = @tasks.order(expired_at: :desc)
      end
    elsif params[:name].blank?
      @tasks = Task.page(params[:page]).per(PER).status_search(params[:status])
    elsif params[:status].blank?
      @tasks = Task.page(params[:page]).per(PER).name_search(params[:name])
    else
      @tasks = Task.page(params[:page]).per(PER).name_and_status_search(params[:name], params[:status])
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
    params.require(:task).permit(:name, :detail, :expired_at, :status, :search, :priority)
  end

  def set_task
    @task = Task.find(params[:id])
  end
end
