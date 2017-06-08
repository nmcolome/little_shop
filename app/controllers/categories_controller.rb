class CategoriesController < ApplicationController

  def show
    @category = Category.find(params[:id])
    @items = @category.items.page(params[:page]).per(12)
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to @category
    else
      render :new
    end
  end

  def new
    @category = Category.new
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
