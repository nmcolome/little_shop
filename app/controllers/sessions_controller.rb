class SessionsController < ApplicationController

  def new
  end

  def create
    @user = User.find_by(username: params[:session][:username])
    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      if current_user.admin?
        redirect_to '/admin/dashboard'
      else
        redirect_to @user
      end
    else
      #incorrect user or password
    end
  end
end
