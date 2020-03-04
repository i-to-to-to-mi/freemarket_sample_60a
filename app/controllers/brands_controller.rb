class BrandsController < ApplicationController
  def show

  end

  def brand_show
    @brand = Brand.find(params[:id])
    @items = @brand.items
  end
end
end
