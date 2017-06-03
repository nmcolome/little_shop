class Admin::DashboardController < Admin::BaseController
  def show
    @orders = Order.all
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])
    @order.update_attribute :status, params[:order][:status]
    @order.save
  end
end
