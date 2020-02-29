class ItemsController < ApplicationController

  before_action :authenticate_user!, only: [:create, :new, :update, :edit]
  before_action :set_item, only: [:show, :destroy]

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

  def edit
    @item = Item.find(params[:id])
    gon.item = @item
    gon.images = @item.images

    require 'base64'
    require 'aws-sdk'

    gon.images_binary_datas = []

    if Rails.env.production?
      client = Aws::S3::Client.new(
                             region: 'ap-northeast-1',
                             access_key_id: Rails.application.credentials.aws[:access_key_id],
                             secret_access_key: Rails.application.credentials.aws[:secret_access_key],
                             )
      @item.images.each do |image|
        binary_data = client.get_object(bucket: 'freemarketsample60a', key: image.src.file.path).body.read
        gon.images_binary_datas << Base64.strict_encode64(binary_data)
      end
    else
      @item.images.each do |image|
        binary_data = File.read(image.src.file.file)
        gon.images_binary_datas << Base64.strict_encode64(binary_data)
      end
    end
  end

  def update
    @item = Item.find(params[:id])

    # 登録済画像のidの配列を生成
    ids = @item.images.map{|image| image.id }
  
    # 登録済画像のうち、編集後もまだ残っている画像のidの配列を生成(文字列から数値に変換)
    exist_ids = registered_image_params[:ids].map(&:to_i)
    
    # 登録済画像が残っていない場合(配列に０が格納されている)、配列を空にする
    exist_ids.clear if exist_ids[0] == 0
    
    if (exist_ids.length != 0 || new_image_params[:images][0] != " ") && @item.update(item_params)

      # 登録済画像のうち削除ボタンをおした画像を削除
      unless ids.length == exist_ids.length
      # 削除する画像のidの配列を生成
        delete_ids = ids - exist_ids
        delete_ids.each do |id|
          @item.images.find(id).destroy
        end
      end

      # 新規登録画像があればcreate
      unless new_image_params[:images][0] == " "
        new_image_params[:images].each do |image|
          @item.images.create(src: image, item_id: @item.id)
        end
      end

      flash[:notice] = '編集が完了しました'
      redirect_to item_path(@item), data: {turbolinks: false}

    else
      flash[:alert] = '未入力項目があります'
      redirect_back(fallback_location: root_path)
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
      images_attributes: [:src,:id])
      .merge(seller_id: current_user.id)
  end

  def set_item
      @item = Item.find(params[:id])
    end

  def registered_image_params
    params.require(:registered_images_ids).permit({ids: []})
  end
  def new_image_params
    params.require(:new_images).permit({images: []})
  end
end
