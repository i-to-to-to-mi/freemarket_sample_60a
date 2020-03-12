class SearchesController < ApplicationController
  before_action :set_ransack
  
  def index
    @all_items = Item.all
    @items = @all_items.where('name LIKE (?)', "%#{params[:search]}%").limit(132)
    if @items.present?
      @count = @items.count
    elsif @items.blank?
      @count = "0"
    else
      @count = @all_items.count
    end
  end

  def detail_search
    @search = params[:q][:name_cont]
    @search_item = Item.ransack(params[:q]) 
    @items = @search_item.result.page(params[:page])
  end

private
  def set_ransack
    @q = Item.ransack(params[:q])
  end

  def category_grandchildren
    @category_grandchildren = Category.find("#{params[:child_id]}").children
  end

  def detail_search_params
    params.require(:q)
    .permit(:name_or_category_name_or_brand_name_cont,
            {category_id_in: []}, 
            :brand_name_cont, 
            :price_gteq, 
            :price_lteq, 
            {condition_in: []}, 
            {shipping_fee_in: []}, 
            {status_in: []})
  end
  
end
