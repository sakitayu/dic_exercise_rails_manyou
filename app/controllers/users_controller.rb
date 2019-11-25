class UsersController < ApplicationController
  def new
    if logged_in?
      redirect_to user_path(current_user.id)
    else
      binding.pry
      @user = User.new
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to tasks_path
    else
      render 'new'
    end
  end

  def show
    if params[:id] == "#{current_user.id}"
      @user = User.find(params[:id])
    else
      redirect_to user_path(current_user.id)
    end
  end

  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end
end
