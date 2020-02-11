class ItemsController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = User.find_by(params[:user_id])
    @items= Item.includes(:images).order('created_at DESC')  
  end

  def new
    @item = Item.new
    @item.images.new
  end

  def create
    @item = Item.new(item_params)
    @item.margin = @item.price*0.1
    @item.profit = @item.price*0.9
    @item.seller_id = current_user.id
    if @item.save!
      redirect_to root_path, notice: '出品完了しました'
    else
      flash[:alert] = '出品に失敗しました。必須項目を確認してください。'
      render :new
    end
  end

private

  def item_params
    params.require(:item).permit(:name, :description, 
    :condition, :cover_postage, :shipping_area, :shipping_date, :price, :margin, :profit, :seller_id,
    :category, images_attributes: [:src])
  end

end



