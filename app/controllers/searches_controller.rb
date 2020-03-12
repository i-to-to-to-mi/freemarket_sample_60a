# class SearchesController < ApplicationController
  
#   def index
#     @items = Item.search(params[:search]).limit(132)
#     @search = params[:search]
#     @category_parent_array = Category.where(ancestry: nil).pluck(:name)
#   end
#   def category_children
#     @category_children = Category.find_by(name: "#{params[:parent_name]}", ancestry: nil).children
#   end

#   def category_grandchildren
#     @category_grandchildren = Category.find("#{params[:child_id]}").children
#   end
# end
class SearchesController < ApplicationController
  before_action :set_ransack
  def index
    @search = Item.search(:name_cont => item.name).result
    @items = @search.result.page(params[:page])
  end

private


  def set_ransack
    @q = Item.ransack(params[:q])
  end
end
