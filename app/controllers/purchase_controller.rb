class PurchaseController < ApplicationController

  before_action :improper_buyer, only: [:show]
  before_action :sold_out, only: [:show, :pay]

  def show
  end

  def pay
  end

  def improper_buyer
    if @item.seller_id == current_user.id
      redirect_to root_path
      flash[:delete] = "自分の商品の購入画面には進めません"
    else
      show
    end
  end

  def sold_out
    if @item.buyer_id.present || @item.seller_id == current_user.id
      redirect_to root_path
      flash[:delete] = "自分自身の商品、もしくは売り切れ商品は購入できません"
    else
      pay
    end
  end

end
