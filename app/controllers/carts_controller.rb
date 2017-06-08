class CartsController < ApplicationController
  include ActionView::Helpers::TextHelper
  before_action :find_item, only: [:create, :destroy, :update]

  def create
    @cart.increase_quantity(@item.id)
    session[:cart] = @cart.contents
    flash[:notice] = "You now have #{pluralize(session[:cart][@item.id.to_s], @item.title)}."
    redirect_to request.referrer
  end

  def index
    @items = @cart.find_quantity_subtotal
  end

  def destroy
    @cart.remove(@item.id)
    flash[:notice] = "Successfully removed #{view_context.link_to(@item.title, item_path(@item))} from your cart.".html_safe
    redirect_back(fallback_location: items_path)
  end

  def update
    @cart.decrease_quantity(@item.id)
    session[:cart] = @cart.contents
    flash[:notice] = "You now have #{pluralize(session[:cart][@item.id.to_s], @item.title)}."
    redirect_to request.referrer
  end

  private

  def find_item
    @item = Item.find(params[:item_id])
  end
end
