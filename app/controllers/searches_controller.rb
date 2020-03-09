class SearchesController < ApplicationController
  
  def index
    @images = Item.find(params[:item_id]).src
    @items= Item.includes(:images).order('created_at DESC') 
    @ladies = Item.search(params[:search]).limit(132)
    @search = params[:search]
    @category_parent_array = Category.where(ancestry: nil).pluck(:name)
  end
  def category_children
    @category_children = Category.find_by(name: "#{params[:parent_name]}", ancestry: nil).children
  end

  def category_grandchildren
    @category_grandchildren = Category.find("#{params[:child_id]}").children
  end

end
