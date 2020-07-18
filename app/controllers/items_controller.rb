class ItemsController < ApplicationController
  def new
    @item = Item.new
    @item.itemimages.build
  end

  def create
    item = Item.new(item_params)
    if item.save
      redirect_to root_path
    else
      redirect_to new_item_path
    end
  private
  def item_params
    params.require(:item).permit(:name, :description, :category_id, :size, :brand_id, :condition_id, :postage_id, :prefecture_id, :preparation_id, :price, itemimages_attributes: [:image]).merge(user_id: 1, status: 1)
  end
  end
end
