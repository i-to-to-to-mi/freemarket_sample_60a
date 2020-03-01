require 'rails_helper'
RSpec.describe Card, type: :model do
  describe '#pay' do
    it "is invalid without a card_number" do
      card = Card.new(card_id: "", exp_month: "12", exp_year: "2020", cvc: "123")
      card.valid?
      expect(card.errors[:card_number]).to include("can't be blank")
    end
  end

end

