class Admin::DashboardController < Admin::BaseController
  def show
    @order_count = Order.all
    if params[:filter] && params[:filter] != "All Orders"
      @orders = Order.orders_filter(params[:filter])
    else
      @orders = Order.order(updated_at: :desc)
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])
    @order.update_attribute :status, params[:order][:status]
    @order.save
    redirect_to admin_dashboard_path(:current_user)
  end
end
