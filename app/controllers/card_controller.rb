class CardController < ApplicationController

  require "payjp"
  before_action :set_card, only: [:new, :delete, :edit]

  def new
    
    redirect_to edit_card_path(current_user) unless @card.blank?
  end

  def pay #payjpとCardのデータベース作成を実施します。
    Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']
    if params['payjp-token'].blank?
      redirect_to action: "new"
    else
      customer = Payjp::Customer.create(card: params['payjp-token'])
      card = Card.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
        if card.save
          redirect_to edit_card_path(current_user)
        else
          redirect_to action: "pay"
          notice[:delete] = "なんかちげー"
        end
    end
  end

  def delete #PayjpとCardデータベースを削除します
    
    Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']
    customer = Payjp::Customer.retrieve(@card.customer_id)
    customer.delete
    @card.delete
    unless @card.blank?
  end
    redirect_to action: "new"
  end

  def edit #Cardのデータpayjpに送り情報を取り出します
    
    Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']
    customer = Payjp::Customer.retrieve(@card.customer_id)
    @default_card_information = customer.cards.retrieve(@card.card_id)
  end

  def set_card
    @card = Card.where(user_id: current_user.id).first
  end
  
end
