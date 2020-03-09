class SearchesController < ApplicationController
  
  def index
    @ladies = Item.search(params[:search]).limit(132)
    @search = params[:search]
  end


end
