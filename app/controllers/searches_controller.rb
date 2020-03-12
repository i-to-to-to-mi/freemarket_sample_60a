class SearchesController < ApplicationController

  def index
    @search = Item.ransack(params[:q])
    @items = @search.result
    @images = Image.where(item_id:1..999)
  end
end
