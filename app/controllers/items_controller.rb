class ItemsController < ApplicationController
  def index
  end

  def new
    @item = Item.new
  end
  
  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path, notice: '住所を登録しました'
    else
      render :new
    end
  end

  
  def new
    @item = Item.new
  end
  
  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path, notice: '住所を登録しました'
    else
      render :new
    end
  end

  def show
    @user = User.new
    @item = Item.find(1)
  end
  

  private
  def item_params
    params.require(:item).permit(:name, :description, :condition, :cover_postage, :shipping_area, :shipping_date, :category_id, :brand_id)
  end
end

