class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user, :current_admin?

  before_action :load_cart

  #before_action :is_correct_user
  # before_filter -> { flash.now[:notice] = flash[:notice].html_safe if flash[:html_safe] && flash[:notice] }


  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_admin?
    current_user && current_user.admin?
  end

  private

  def load_cart
    @cart ||= Cart.new(session[:cart])
  end

  def is_correct_user
    if current_user.default? && current_user != @user
      render file:"/public/404"
    end
  end
end
