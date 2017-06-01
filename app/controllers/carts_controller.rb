class CartsController < ApplicationController
  include ActionView::Helpers::TextHelper

  def create
    @item = Item.find(params[:item_id])
    @cart.update_quantity(@item.id)
    session[:cart] = @cart.contents
    flash[:notice] = "You now have #{pluralize(session[:cart][@item.id.to_s], @item.title)}."
    redirect_to :back
  end

  def index
    @items = @cart.find_quantity_subtotal
  end

  def destroy
    @item = Item.find(params[:item_id])
    @cart.remove(@item.id)
    flash[:notice] = "Successfully removed " + <%= link_to @item.title, item_path(@item) %> + " from your cart."
    redirect_to :back
  end
end
