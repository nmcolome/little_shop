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
    @items = Hash.new
    @subtotal = Hash.new
    session[:cart].each do |k,v|
      @items[Item.find(k)] = {:quantity => v, :subtotal => Item.find(k).price * v}
    end

  end
end