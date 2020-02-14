class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :new]

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
    @item.update(price: params[:price], profit_price: params[:profit_price], margin_price: params[:margin_price])
    @item.seller_id = current_user.id
    if @item.save
      redirect_to root_path, notice: '出品完了しました'
    else
      flash[:alert] = '出品に失敗しました。必須項目を確認してください。'
      render :new
    end
  end

  def show
    # ここもおそらく後々before_action :authenticate_user!, only: に加えるべき
    @user = User.new
    @item = Item.find(1)
  end

private

  def item_params
    params.require(:item).permit(:name, :description, 
    :condition, :cover_postage, :prefectures, :shipping_date, :price, :margin_price, :profit_price, :seller_id,
    :category, images_attributes: [:src])
  end
end
