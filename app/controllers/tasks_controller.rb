class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  PER = 10

  def index
    @tasks = Task.where(user_id: current_user.id)
    if params[:name].blank? && params[:status].blank?
      @tasks = @tasks.page(params[:page]).per(PER)
      if params[:sort_expired].blank? && params[:sort_priority].blank?
        @tasks = @tasks.order(created_at: :desc)
      elsif params[:sort_expired].blank?
        @tasks = @tasks.order(priority: :asc)
      else
        @tasks = @tasks.order(expired_at: :desc)
      end
    elsif params[:name].blank?
      @tasks = Task.page(params[:page]).per(PER).status_search(params[:status])
      flash[:notice] = "「#{params[:status]}」の検索結果"
    elsif params[:status].blank?
      @tasks = Task.page(params[:page]).per(PER).name_search(params[:name])
      flash[:notice] = "「#{params[:name].slice(0, 6)}」の検索結果"
    else
      @tasks = Task.page(params[:page]).per(PER).name_and_status_search(params[:name], params[:status])
      flash[:notice] = "「#{params[:status]}」と「#{params[:name].slice(0, 6)}」の検索結果"
    end
    
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.create(task_params)
    @task = current_user.tasks.build(task_params)
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
