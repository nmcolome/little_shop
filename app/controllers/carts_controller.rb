class CartsController < ApplicationController
  include ActionView::Helpers::TextHelper

  def create
    @item = Item.find(params[:item_id])
    @cart.update_quantity(@item.id)
    session[:cart] = @cart.contents
    flash[:notice] = "You now have #{pluralize(session[:cart][@item.id.to_s], @item.title)}."
    redirect_back(fallback_location: items_path)
  end

  def index
    @items = @cart.find_quantity_subtotal
  end

  def destroy
    @item = Item.find(params[:item_id])
    @cart.remove(@item.id)
    flash[:notice] = "Successfully removed #{view_context.link_to(@item.title, item_path(@item))} from your cart.".html_safe
    redirect_back(fallback_location: items_path)
  end
end
