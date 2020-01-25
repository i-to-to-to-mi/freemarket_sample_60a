class ItemsController < ApplicationController
  def index
  end
  
  def show
    @user = User.new
  end

end
