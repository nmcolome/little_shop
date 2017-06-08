class Admin::ItemsController < Admin::BaseController
  before_action :find_item, only: [:update, :edit]

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
    @categories = Category.all.pluck(:name)
  end

  def update
    @item.update(item_params)
    flash.notice = "This item has now been edited"
    redirect_to item_path(@item)
  end

  private

  def item_params
    params.require(:item).permit(:title, :description, :price, :status, :image_att)
  end

  def find_item
    @item = Item.find(params[:id])
  end

end
