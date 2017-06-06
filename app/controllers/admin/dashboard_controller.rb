class Admin::DashboardController < Admin::BaseController
  def show
    @orders = Order.order(updated_at: :desc)
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
