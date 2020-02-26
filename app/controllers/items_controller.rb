class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :destroy, :ensure_correct_user]
  before_action :authenticate_user!, only: [:create, :new]
  # のちにeditもensure_correct_userに追加（by　金田さん）
  before_action :ensure_correct_user, only: [:destroy]

  def index
    @items= Item.includes(:images).order('created_at DESC') 
    @ladies = Item.where(category: "レディース").order("created_at DESC").limit(10)
    @mens = Item.where(category: "メンズ").order("created_at DESC").limit(10)
    @electronics = Item.where(category: "家電・スマホ・カメラ").order("created_at DESC").limit(10)
    @toys= Item.where(category: "おもちゃ・ホビー・グッズ").order("created_at DESC").limit(10)
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

  def destroy
    if @item.destroy
      flash[:delete] = "商品を削除しました"
      redirect_to root_path
    else
      render :new
    end
  end

  def ensure_correct_user
    if @item.seller_id != current_user.id
      redirect_to item_path
      flash[:delete] = "権限がありません"
    else
      destroy
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
      images_attributes: [:src,:id])
      .merge(seller_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

end
