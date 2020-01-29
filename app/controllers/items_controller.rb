class ItemsController < ApplicationController
  def index
  end
  
  def show
    @user = User.new
    @item = Item.find(1)
  end
end
