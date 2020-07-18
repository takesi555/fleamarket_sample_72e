class ItemsController < ApplicationController
  def new
    @item = Item.new
    @item.itemimages.build
  end

  def create
  end
end
