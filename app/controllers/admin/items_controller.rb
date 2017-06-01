class Admin::ItemsController < ApplicationController

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to item_path(@item)
    else
      render :new, notice: "Incorrect information. Please try again."
    end
  end

  def show
    
  end

  private

  def item_params
    params.require(:item).permit(:title, :description, :price, :status)
  end
end