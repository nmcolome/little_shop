class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
    else

    end
  end

  def show

  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(role_params)
    redirect_to edit_user_path(@user)
  end

private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :username, :password_digest, :address, :city, :state, :zipcode, :role)
  end

  def role_params
    params.require(:user).permit(:role)
  end
end
