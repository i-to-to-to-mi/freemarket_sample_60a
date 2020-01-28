class ItemsController < ApplicationController
  def index
    @items= Item.includes(:images).order('created_at DESC')
  end

  def new
    @item = Item.new
    @item.images.new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def show
  end
end