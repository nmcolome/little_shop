class OrdersController < ApplicationController

  def show
    @order = Order.find(params[:id])
    @user = User.find(params[:user_id])
  end

  def create
    @order = Order.create(user_id: current_user.id)
    @cart.contents.each do |k,v|
      @order.order_items << OrderItem.create(item_id: k.to_i, quantity: v)
    end
    flash[:notice] = "Order was successfully placed"
    redirect_to orders_path
  end

  def index
    @orders = current_user.orders(created_at: :desc)
  end
end
