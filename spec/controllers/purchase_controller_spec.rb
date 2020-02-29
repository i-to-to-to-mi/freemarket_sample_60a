require 'rails_helper'

RSpec.describe PurchaseController, type: :controller do
  let(:user) { create(:user) }
  render_views
  let(:card) { create(:card) }
  
  describe 'GET #show' do
  before do
    login user
  end
    it 'assigns the requested card to @default_card_information' do
      card = create(:card)
      get :show, params: { id: card }
      expect(assigns(:card)).to eq card
      
    end
  end

  

end
