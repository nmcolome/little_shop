class Admin::ItemsController < Admin::BaseController

  def new
    @item = Item.new
    @categories = Category.all.pluck(:name)
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to item_path(@item)
    else
      render :new, notice: "Incorrect information. Please try again."
    end
  end

  def edit
    @item = Item.find(params[:id])
    @categories = Category.all.pluck(:name)
  end

  def update
    @item = Item.find(params[:id])
    @item.update(item_params)

    flash.notice = "This item has now been edited"

    redirect_to item_path(@item)
  end

  private

  def item_params
    params.require(:item).permit(:title, :description, :price, :status, :image_att)
  end
end
