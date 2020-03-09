class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :new, :update, :edit]
  before_action :set_item, only: [:update, :edit, :show, :destroy]
  before_action :set_category, only: [:new,:index,:show]

  def index
    @items= Item.includes(:images).order('created_at DESC') 
    @ladies = Item.where(category_id:14..211).order("created_at DESC").limit(10)
    @men = Item.where(category_id:212..356).order("created_at DESC").limit(10)
    @electronics = Item.where(category: "家電・スマホ・カメラ").order("created_at DESC").limit(10)
    @toys= Item.where(category: "おもちゃ・ホビー・グッズ").order("created_at DESC").limit(10)
    @channel = Item.where(brand_id: 1).order("created_at DESC").limit(10)
    @louisvuitton = Item.where(brand_id: 2).order("created_at DESC").limit(10)
    @supreme= Item.where(brand_id: 3).order("created_at DESC").limit(10)
    @nike= Item.where(brand_id: 4).order("created_at DESC").limit(10)
  end

  def new
    if user_signed_in?
      @item = Item.new
      @item.images.new
      @brands = Brand.where('name LIKE(?)', "%#{params[:keyword]}%")

      #データベースから、親カテゴリーのみ抽出し、配列化
      @category_parent_array = Category.where(ancestry: nil).pluck(:name)
    else
      redirect_to root_path
    end
  end

    # 以下全て、formatはjsonのみ
    # 親カテゴリーが選択された後に動くアクション
  def category_children
      #選択された親カテゴリーに紐付く子カテゴリーの配列を取得
      @category_children = Category.find_by(name: "#{params[:parent_name]}", ancestry: nil).children
  end

  # 子カテゴリーが選択された後に動くアクション
  def category_grandchildren
  #選択された子カテゴリーに紐付く孫カテゴリーの配列を取得
      @category_grandchildren = Category.find("#{params[:child_id]}").children
  end


  def create
    @item = Item.new(item_params)
    @item.update(price: params[:price], profit_price: params[:profit_price], margin_price: params[:margin_price])
    brand = Brand.find_by(name: params[:item][:brand_id])
    if brand.present?
      @item.update(brand_id: brand.id)
    else
    @new_brand = Brand.new(name: params[:item][:brand_id])
      if Brand.where.not(name: @new_brand.name)
      @new_brand.save if @brand.present?
      @item.update(brand_id: @new_brand.id)
      else
      render :new
      flash[:alert] = 'ブランドの登録に失敗しました'
      end
    end
    if @item.valid? && params[:item_images].present?
      @item.save
      params[:item_images][:image].each do |image|
        @item.images.create(src: image, item_id: @item.id)
      end
      redirect_to root_path, notice: '出品完了しました'
    else
      render :new
      flash[:alert] = '出品に失敗しました。必須項目を確認してください。'
    end
  end

  def edit
    @category_parent_array = Category.where(ancestry: nil).pluck(:name)
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

      redirect_to item_path(@item), data: {turbolinks: false}
      flash[:notice] = '編集が完了しました'

    else
      redirect_back(fallback_location: root_path)
      flash[:alert] = '未入力項目があります'
    end

  end

  def show
  end

  def destroy
    if user_signed_in?
      @item.destroy
      flash[:delete] = "商品を削除しました"
      redirect_to root_path
    else
      redirect_back(fallback_location: item_path)
    end
  end

  def image
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
      :brand_id,
      :category_id, 
      images_attributes: [:src,:id])
      .merge(seller_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
    @grandchild = Category.find(@item[:category_id])
    @child = @grandchild.parent
    @parent = @child.parent
    end

  def registered_image_params
    params.require(:registered_images_ids).permit({ids: []})
  end

  def new_image_params
    params.require(:new_images).permit({images: []})
  end

  def set_category
    @parents = Category.all.order("id ASC").limit(13)
  end
end

