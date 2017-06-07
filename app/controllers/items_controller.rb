class ItemsController < ApplicationController

  def show
    @item = Item.find(params[:id])
  end

  def index
    @items = Item.page(params[:page]).per(12)
  end
end
