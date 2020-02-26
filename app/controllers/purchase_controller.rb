class PurchaseController < ApplicationController

  before_action :improper_buyer, only: [:show]
  before_action :sold_out, only: [:show, :pay]

  require 'payjp'

  def show
  end

  def pay
  end

  # def show
  #   card = Card.where(user_id: current_user.id).first
  #   #Cardテーブルは前回作成、テーブルからpayjpの顧客IDを検索
  #   if card.blank?
  #     #登録された情報がない場合にカード登録画面に移動
  #     redirect_to controller: "card", action: "new"
  #   else
  #     Payjp.api_key = "sk_test_a0029dc5466705b77c5d7bab"
  #     #保管した顧客IDでpayjpから情報取得
  #     customer = Payjp::Customer.retrieve(card.customer_id)
  #     #保管したカードIDでpayjpから情報取得、カード情報表示のためインスタンス変数に代入
  #     @default_card_information = customer.cards.retrieve(card.card_id)
  #   end
  # end

  
  # def index
  #   card = Card.where(user_id: current_user.id).first
  #   #Cardテーブルは前回記事で作成、テーブルからpayjpの顧客IDを検索
  #   if card.blank?
  #     #登録された情報がない場合にカード登録画面に移動
  #     redirect_to controller: "card", action: "new"
  #   else
  #     Payjp.api_key = "sk_test_a0029dc5466705b77c5d7bab"
  #     #保管した顧客IDでpayjpから情報取得
  #     customer = Payjp::Customer.retrieve(card.customer_id)
  #     #保管したカードIDでpayjpから情報取得、カード情報表示のためインスタンス変数に代入
  #     @default_card_information = customer.cards.retrieve(card.card_id)
  #   end
  # end

  # def pay
  #   card = Card.where(user_id: current_user.id).first
  #   Payjp.api_key = "sk_test_a0029dc5466705b77c5d7bab"
  #   Payjp::Charge.create(
  #   amount: 6000, #支払金額を入力（itemテーブル等に紐づけても良い）
  #   # card: params['payjp-token'], # フォームを送信すると生成されるトークン
  #   customer: card.customer_id, #顧客ID
  #   currency: 'jpy', #日本円
  # )
  # redirect_to action: 'done' #完了画面に移動
  # end



  # def improper_buyer
  #   if @item.seller_id == current_user.id
  #     redirect_to root_path
  #     flash[:delete] = "自分の商品の購入画面には進めません"
  #   else
  #     show
  #   end
  # end

  # def sold_out
  #   if @item.buyer_id.present || @item.seller_id == current_user.id
  #     redirect_to root_path
  #     flash[:delete] = "自分自身の商品、もしくは売り切れ商品は購入できません"
  #   else
  #     pay
  #   end
  # end

end
