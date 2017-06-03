class OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
    @user = User.find(params[:user_id])
  end
end
