class Admin::UsersController < ApplicationController
  def index
    if current_user.admin == true
      @users = User.all.order(id: :asc)
    else
      redirect_to errors_users_path
    end
  end


  def new
    if current_user.admin == true
      @user = User.new
    else
      redirect_to errors_users_path
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path
    else
      render 'new'
    end
  end

  def show
    if current_user.admin == true
      @user = User.find(params[:id])
      @tasks = Task.where(user_id: @user.id)
    else
      redirect_to errors_users_path
    end
  end

  def edit
    if current_user.admin == true
      @user = User.find(params[:id])
    else
      redirect_to errors_users_path
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_user_path(@user.id), notice: "ユーザーを編集しました！"
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    if User.where(admin: true).count <= 1
      redirect_to admin_users_path, notice: "管理者ユーザーは最低一人は必要なので削除できません！"
    else
      @user.destroy
      redirect_to admin_users_path, notice: "ユーザーを削除しました！"
    end
  end

  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :admin,
                                 :password_confirmation)
  end
end
