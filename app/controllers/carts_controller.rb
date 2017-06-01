class CartsController < ApplicationController
  include ActionView::Helpers::TextHelper

  def create
    @item = Item.find(params[:item_id])
    session[:cart] ||= {}
    session[:cart][@item.id.to_s] = (session[:cart][@item.id.to_s] || 0) + 1
    flash[:notice] = "You now have #{pluralize(session[:cart][@item.id.to_s], @item.title)}."
    redirect_to :back
  end

  def index
    @items = Hash.new
    session[:cart].each do |k,v|
      @items[Item.find(k)] = v
    end
  end
end