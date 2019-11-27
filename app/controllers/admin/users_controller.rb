class Admin::UsersController < ApplicationController
  def index
    @users = User.all
  end


  def new
    #if logged_in?
      #redirect_to user_path(current_user.id)
    #else
      @user = User.new
    #end
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
    #if params[:id] == "#{current_user.id}"
      @user = User.find(params[:id])
    #else
      #redirect_to user_path(current_user.id)
    #end
  end

  def edit
    @user = User.find(params[:id])
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
    @user.destroy
    redirect_to admin_users_path, notice: "ユーザーを削除しました！"
  end

  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end
end
