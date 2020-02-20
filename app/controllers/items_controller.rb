class ItemsController < ApplicationController
  before_action :set_item, only: [:show]
  before_action :authenticate_user!, only: [:create, :new]

  def index
    @items= Item.includes(:images).order('created_at DESC') 
    @ladies = Item.where(seller_id:1..199).order("created_at DESC").limit(10)
  end

  def new
    @item = Item.new
    @item.images.new
  end

  def create
    @item = Item.new(item_params)
    @item.update(price: params[:price], profit_price: params[:profit_price], margin_price: params[:margin_price])
    if @item.valid? && params[:item_images].present?
      @item.save
      params[:item_images][:image].each do |image|
        @item.images.create(src: image, item_id: @item.id)
      end
      redirect_to root_path, notice: '出品完了しました'
    else
      flash[:alert] = '出品に失敗しました。必須項目を確認してください。'
      render :new
    end
  end

  def show
  end

  def get_image
    @images = Item.find(params[:item_id]).src
  end


private

  def item_params
    params.require(:item).permit(
      :name, 
      :description, 
      :condition, 
      :cover_postage, 
      :prefectures, 
      :shipping_date, 
      :price, 
      :margin_price, 
      :profit_price, 
      :seller_id,
      :category, 
      images_attributes: [:src,:id])
      .merge(seller_id: current_user.id)
  end

    def set_item
      @item = Item.find(params[:id])
    end
end
