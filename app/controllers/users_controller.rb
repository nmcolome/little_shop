class UsersController < ApplicationController
before_action :is_correct_user, only: [:edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to '/dashboard'
    else
      flash[:alert] = "Please complete requirements before creating account"
      render :new
    end
  end

  def show
    #binding.pry
    #if current_user
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(role_params)
    redirect_to edit_user_path(@user), alert: "User role updated."
  end

private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :username, :password, :address, :city, :state, :zipcode)
  end

  def role_params
    params.require(:user).permit(:role)
  end
end
