class SearchesController < ApplicationController
  before_action :set_ransack
  
  def index
    @item = Item.search(params[:search]).limit(132)
    @search = params[:search]
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
