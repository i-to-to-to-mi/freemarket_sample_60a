class PurchaseController < ApplicationController
  require 'payjp'
  before_action :set_item, only: [:show, :pay, :done]
  before_action :set_card, only: [:show, :pay, :done]

  def show
    # @user = User.find(current_user.id)
    if @card.blank?
      #登録された情報がない場合にカード登録画面に移動
      redirect_to controller: "card", action: "new"
    else
      Payjp.api_key = 'sk_test_a0029dc5466705b77c5d7bab'
      #保管した顧客IDでpayjpから情報取得
      customer = Payjp::Customer.retrieve(@card.customer_id)
      #保管したカードIDでpayjpから情報取得、カード情報表示のためインスタンス変数に代入
      @default_card_information = customer.cards.retrieve(@card.card_id)
    end
  end

  def pay
    Payjp.api_key = 'sk_test_a0029dc5466705b77c5d7bab'
    Payjp::Charge.create(
    amount: @item.price,
    customer: @card.customer_id, #顧客ID
    currency: 'jpy',
  )
  redirect_to done_purchase_index_path(id:@item.id) #完了画面に移動
  end
  def done
  # @user = User.find(current_user.id)
  customer = Payjp::Customer.retrieve(@card.customer_id)
  @default_card_information = customer.cards.retrieve(@card.card_id)
  @item_buyer= Item.find(params[:id])
  @item_buyer.update( buyer_id: current_user.id)
    if @item_buyer.save
    else
      redirect_to parchase_path
      notice[:delete] = "購入できませんでした"
    end
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def set_card
    @card = Card.where(buyer_id: current_user.id).first
  end
end
