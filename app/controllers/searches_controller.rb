class SearchesController < ApplicationController

  def index
    @search = Item.ransack(params[:q])
    @items = @search.result
  end
end
