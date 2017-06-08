class CategoriesController < ApplicationController

  def show
    @category = Category.find(params[:id])
    @items = @category.items.page(params[:page]).per(12)
  end
end