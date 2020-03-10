class CardController < ApplicationController

  require "payjp"
  before_action :card_presence, only: [:delete, :edit]

  def new
    # あればEDitへ流す。なければpay    
    redirect_to edit_card_path(current_user) if current_user.card_id.present?
  end

  def pay #payjpとCardのデータベース作成を実施します。
    Payjp.api_key = 'sk_test_a0029dc5466705b77c5d7bab'
    customer = Payjp::Customer.create(card: params['payjp-token'])
    @card = Card.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      if @card.save
        # Userにcard_idを入れます
        current_user.update!(card_id: @card.id)
        redirect_to root_path
        flash[:delete] = "カードの登録に成功しました"
        # redirect_to edit_card_path(current_user)
      else
        redirect_to action: "pay"
        flash[:delete] = "カードの登録に失敗しました"
      end
  end

  def delete #PayjpとCardデータベースを削除します
    Payjp.api_key = 'sk_test_a0029dc5466705b77c5d7bab'
    customer = Payjp::Customer.retrieve(@card.customer_id)
    customer.delete
    @card.delete
    unless @card.blank?
    end
    #Itemのテーブルからも削除します
    current_user.update(card_id: nil)
    redirect_to action: "new"
    flash[:delete] = "カードの削除に成功しました"
  end

  def edit #Cardのデータpayjpに送り情報を取り出します
    Payjp.api_key = 'sk_test_a0029dc5466705b77c5d7bab'
    customer = Payjp::Customer.retrieve(@card.customer_id)
    @default_card_information = customer.cards.retrieve(@card.card_id)
  end


  def card_presence
    # Cardの登録がなされてない場合入れない入れなくする
    if current_user.card_id.nil?
      redirect_back(fallback_location: root_path)
    else
      # 入れたら登録ずみUserテーブルにあるcard_idとCardテーブルにあるidが同じカードを探して代入
      @card = Card.find_by(id: current_user.card_id)
    end
  end

end
