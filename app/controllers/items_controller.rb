class ItemsController < ApplicationController

  def index
  end

  def create
    @item = User(item_params)
    if @post.save
      flash[:success] = "Avatar created!"
      redirect_to root_url
    end
  end

private
  def post_params
    params.require(:image).permit(:avatar)
  end

end
