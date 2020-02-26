class CardController < ApplicationController

  require "payjp"

  def new
    card = Card.where(user_id: current_user.id).first
    if card.blank?

    else
    redirect_to action: "edit"
    end
  end

  def pay #payjpとCardのデータベース作成を実施します。
    Payjp.api_key = "sk_test_a0029dc5466705b77c5d7bab"
    if params['payjp-token'].blank?
      redirect_to action: "new"
    else
      customer = Payjp::Customer.create(
      card: params['payjp-token'],
      )
      @card = Card.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      if @card.save
        redirect_to action: "edit"
      else
        redirect_to action: "new"
      end
    end
  end

  def delete #PayjpとCardデータベースを削除します
    card = Card.where(user_id: current_user.id).first
    if card.blank?
    else
      Payjp.api_key = "sk_test_a0029dc5466705b77c5d7bab"
      customer = Payjp::Customer.retrieve(card.customer_id)
      customer.delete
      card.delete
    end
      redirect_to action: "new"
  end

  def edit #Cardのデータpayjpに送り情報を取り出します
    card = Card.where(user_id: current_user.id).first
    Payjp.api_key = "sk_test_a0029dc5466705b77c5d7bab"
    customer = Payjp::Customer.retrieve(card.customer_id)
    @default_card_information = customer.cards.retrieve(card.card_id)
  end
  
end
