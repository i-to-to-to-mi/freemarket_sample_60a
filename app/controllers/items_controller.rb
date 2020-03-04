class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :destroy]
  before_action :authenticate_user!, only: [:create, :new]

  def index
    @items= Item.includes(:images).order('created_at DESC') 
    @ladies = Item.where(category: "レディース").order("created_at DESC").limit(10)
    @mens = Item.where(category: "メンズ").order("created_at DESC").limit(10)
    @electronics = Item.where(category: "家電・スマホ・カメラ").order("created_at DESC").limit(10)
    @toys= Item.where(category: "おもちゃ・ホビー・グッズ").order("created_at DESC").limit(10)
    @channel = Item.where(brand_id: 2).order("created_at DESC").limit(10)
    @louisvuitton = Item.where(brand_id: 6).order("created_at DESC").limit(10)
    @supreme= Item.where(brand_id: 7).order("created_at DESC").limit(10)
    @nike= Item.where(brand_id: 8).order("created_at DESC").limit(10)
  end

  def new
    @item = Item.new
    @item.images.new
    @brands = Brand.where('name LIKE(?)', "%#{params[:keyword]}%")
    respond_to do |format|
      format.html
      format.json
    end
  end

  def create
    @item = Item.new(item_params)
    @item.update(price: params[:price], profit_price: params[:profit_price], margin_price: params[:margin_price])
    brand_id = Brand.find_by(name: params[:item][:brand_id])
    brand_id = Brand.create(name: params[:item][:brand_id]) unless brand_id.present?
      
    @item.brand_id = brand_id.id 
  
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

  def destroy
    if @item.destroy
      flash[:delete] = "商品を削除しました"
      redirect_to root_path
    else
      render :new
    end
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
      :brand_id,
      images_attributes: [:src,:id])
      .merge(seller_id: current_user.id)
  end

    def set_item
      @item = Item.find(params[:id])
    end
end
