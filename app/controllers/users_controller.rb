class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to tasks_path(@user.id)
    else
      render 'new'
    end
  end

  def show
    if params[:id] == "#{current_user.id}"
    #binding.pry
      @user = User.find(params[:id])
    else
      #render 'show'
      redirect_to user_path(current_user.id)
      #binding.pry
    end
  end

  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end
end
