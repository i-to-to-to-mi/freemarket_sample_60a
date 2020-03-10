class PurchaseController < ApplicationController
  require 'payjp'
  before_action :set_item, only: [:show, :pay, :done]


  def show
    card = Card.where(user_id: current_user.id).first
    #Cardテーブルは前回記事で作成、テーブルからpayjpの顧客IDを検索
    if card.blank?
      #登録された情報がない場合にカード登録画面に移動
      redirect_to controller: "card", action: "new"
    else
      Payjp.api_key = 'sk_test_a0029dc5466705b77c5d7bab'
      #保管した顧客IDでpayjpから情報取得
      customer = Payjp::Customer.retrieve(card.customer_id)
      #保管したカードIDでpayjpから情報取得、カード情報表示のためインスタンス変数に代入
      @default_card_information = customer.cards.retrieve(card.card_id)
    end
  end

  def pay
    card = Card.where(user_id: current_user.id).first
    Payjp.api_key = 'sk_test_a0029dc5466705b77c5d7bab'
    Payjp::Charge.create(
      amount: @item.price,
      customer: card.customer_id, #顧客ID
      currency: 'jpy',
  )
  redirect_to action: 'done' #完了画面に移動
  end

  def done
  customer = Payjp::Customer.retrieve(@card.customer_id)
  @default_card_information = customer.cards.retrieve(@card.card_id)
  @item.update( buyer_id: current_user.id)
    if @item.save
    else
      redirect_to parchase_path
      notice[:delete] = "購入できませんでした"
    end
  end

  def set_item
    @item = Item.find(params[:id])
  end

end
