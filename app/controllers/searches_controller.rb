class SearchesController < ApplicationController
  before_action :set_ransack
  
  def index
    @ladies = Item.search(params[:search]).limit(132)
    @search = params[:search]
  end

  def detail_search
    @search = params[:q][:name_cont]
    @search_item = Item.ransack(params[:q]) 
    @ladies = @search_item.result.page(params[:page])
  end

  private
    def detail_search_params
      params.require(:q)
      .permit(:name_cont,
              :price_gteq, 
              :price_lteq, 
              :sorts,
              {state_in: []}, 
              {fee_payer_in: []}, 
              {status_in: []})
    end

    def set_ransack
      @q = Item.ransack(params[:q])
    end
  
end
