class ItemsController < ApplicationController
  def index
    @items= Item.includes(:images).order('created_at DESC')
  end

  def new
    @item = Item.new
    @item.images.new
  end

  def create
    @item = Item.new(total_item_info)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def show
  end                                                                                                                                                                                                                                                                                                                                                                 

private

  def item_params
    params.require(:item).permit(:name, :description, :condition, :cover_postage, :shipping_area, :shipping_date, :profit, :category_id, :item_id, :seller_id, :brand_id, images_attributes: [:src])
  end

  def total_item_info
    item_params.merge(@item.set_extra_information)
  end
end



