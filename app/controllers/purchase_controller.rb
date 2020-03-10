class PurchaseController < ApplicationController
  require 'payjp'
  before_action :set_item, only: [:show, :pay, :done]
  before_action :set_card, only: [:pay, :done]

  def show    
    if current_user.card_id.present?
        @card = Card.where(buyer_id: current_user.id).first
        Payjp.api_key = 'sk_test_a0029dc5466705b77c5d7bab'
        #保管した顧客IDでpayjpから情報取得
        customer = Payjp::Customer.retrieve(@card.customer_id)
        #保管したカードIDでpayjpから情報取得、カード情報表示のためインスタンス変数に代入
        @default_card_information = customer.cards.retrieve(@card.card_id)
    else
      redirect_back(fallback_location: root_path)
      flash[:notice] = 'まずはクレジットカードの登録をしてください'
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
  customer = Payjp::Customer.retrieve(@card.customer_id)
  @default_card_information = customer.cards.retrieve(@card.card_id)
  @item_buyer= Item.find(params[:id])
  @item_buyer.update( buyer_id: current_user.id)
    if @item_buyer.save
    else
      redirect_to parchase_path
      flash[:notice] = '編集が完了しました'
    end
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def set_card
    @card = Card.where(buyer_id: current_user.id).first
  end
end
