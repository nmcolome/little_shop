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
  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :username, :password_digest, :address, :city, :state, :zipcode, :role)
  end
end