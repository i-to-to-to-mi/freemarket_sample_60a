require 'rails_helper'
RSpec.describe Image, type: :model do
  describe '#create' do
    #imageが存在すれば登録できること
    context 'can save' do
      it 'is valid with [src] [item_id] [id]' do
        image = build(:image)
        expect(image).to be_valid
        end

    # 2. src(画像)が空では登録できないこと
      it "is invalid without a src" do
        image = build(:image, src: nil)
        image.valid?
        expect(image.errors[:src]).to include("を入力してください")
        end

    # ３. item_idが空では登録できないこと
      it "is invalid without an item_id" do
        image = build(:image, item_id: nil)
        image.valid?
        expect(image.errors[:item_id]).to include("を入力してください")
      end
    end
  end
end