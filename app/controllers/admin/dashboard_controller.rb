class Admin::DashboardController < Admin::BaseController
  def show
    if params[:filter] == "Ordered"
      @orders = Order.where(status: "Ordered").order(updated_at: :desc)
      @order_count = Order.all
    elsif params[:filter] == "Paid"
      @orders = Order.where(status: "Paid").order(updated_at: :desc)
      @order_count = Order.all
    elsif params[:filter] == "Cancelled"
      @orders = Order.where(status: "Cancelled").order(updated_at: :desc)
      @order_count = Order.all
    elsif params[:filter] == "Completed"
      @orders = Order.where(status: "Completed").order(updated_at: :desc)
      @order_count = Order.all
    else
      @orders = Order.order(updated_at: :desc)
      @order_count = Order.all
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
