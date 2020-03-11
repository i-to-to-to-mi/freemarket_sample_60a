class PurchaseController < ApplicationController
  require 'payjp'
  before_action :set_item, only: [:show, :pay, :done]
  before_action :set_card, only: [:pay, :done]
  before_action :anti_buy_my_own, only: [:pay, :show]
  before_action :anti_buy_sold_item, only: [:pay, :show]

  def show
    # card_idの有無で分岐
    if current_user.card_id.present?
      @card = Card.find_by(id: current_user.card_id)
      Payjp.api_key = 'sk_test_a0029dc5466705b77c5d7bab'
      #保管した顧客IDでpayjpから情報取得
      customer = Payjp::Customer.retrieve(@card.customer_id)
      #保管したカードIDでpayjpから情報取得、カード情報表示のためインスタンス変数に代入
      @default_card_information = customer.cards.retrieve(@card.card_id)
    else
      # card_idがないつまり未登録。これで購入画面侵入を防いだ。
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
  # ここでItemのbuyer_idをupdate
  @item_buyer= Item.find(params[:id])
  @item_buyer.update( buyer_id: current_user.id)
    if @item_buyer.save
    else
      redirect_to parchase_path
      flash[:delete] = "購入できませんでした"
    end
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def set_card
    @card = Card.find_by(id: current_user.card_id)
  end

  def anti_buy_my_own
    @item = Item.find(params[:id])
    if @item.seller_id == current_user.id
      redirect_to root_path
      flash[:notice] = "自分で自分の買うとかないでしょ・・・"
    end
  end

  def anti_buy_sold_item
    @item = Item.find(params[:id])
    if @item.buyer_id.present?
      redirect_to root_path
      flash[:notice] = "売り切れだっつーの"
    end
  end

end
