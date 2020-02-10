require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @user = FactoryBot.build(:user)
    @item = FactoryBot.build(:item)
  end
  
    describe '#create' do
    #1,name,description, condition, cover_postage, shipping_area, shipping_date, category, imageが存在すれば登録できること
      it "is valid with a name, description, condition, cover_postage, shipping_area, shipping_date, category, image" do
        item = build(:item)
        expect(item).to be_valid
      end

      # 2. nameが空では登録できないこと
      it "is invalid without a name" do
        item = build(:item, name: nil)
        item.valid?
        expect(item.errors[:name]).to include("を入力してください")
      end

      # 3. descriptionが空では登録できないこと
      it "is invalid without a description" do
        item = build(:item, description: nil)
        item.valid?
        expect(item.errors[:description]).to include("を入力してください")
      end

      # 4. descriptionが1000文字以下では登録できないこと
      it "is invalid with a description with more than 1000 characters" do
        item = build(:item, description: "a" *1001)
        item.valid?
        expect(item.errors[:description]).to include("は1000文字以内で入力してください")
      end


      # 5. coditionが空では登録できないこと
      it "is invalid without a condition" do
        item = build(:item, condition: nil)
        item.valid?
        expect(item.errors[:condition]).to include("を入力してください")
      end
      
      #6. cover_postageが空では登録できないこと
      it "is invalid without a cover_postage" do
        item = build(:item, cover_postage: nil)
        item.valid?
        expect(item.errors[:cover_postage]).to include("を入力してください")
      end

      #7. shipping_areaが空では登録できないこと
      it "is invalid without a shipping_area" do
        item = build(:item, shipping_area: nil)
        item.valid?
        expect(item.errors[:shipping_area]).to include("を入力してください")
      end

      #8. shipping_dateが空では登録できないこと
      it "is invalid without a shipping_date" do
        item = build(:item, shipping_date: nil)
        item.valid?
        expect(item.errors[:shipping_date]).to include("を入力してください")
      end


      #9. categoryが空では登録できないこと
      it "is invalid without a category" do
        item = build(:item, category: nil)
        item.valid?
        expect(item.errors[:category]).to include("を入力してください")
      end

      # 10.nameの文字数制限
      it "is invalid for name to have no character " do
        item = build(:item, name: nil)
        item.valid?
        expect(item.errors[:name]).to include("を入力してください", "は1文字以上で入力してください")
      end
      it "is invalid for name to have more than 40 characters" do
        item = build(:item, name: "アイウエオあいうえおアイウエオあいうえおアイウエオあいうえおアイウエオあいうえおあ")
        item.valid?
        expect(item.errors[:name]).to include("は40文字以内で入力してください")
      end

      # 11.priceのカラム形の制限
      it "is invalid without a price int" do
        item = build(:item,price: "ああああ")
        item.valid?
        expect(item.errors[:price]).to include("は数値で入力してください")
      end

      #12.priceが300円から9,999,999円の間
      it "is invalid for price below 300 yen " do
        item = build(:item, price: "299")
        item.valid?
        expect(item.errors[:price]).to include("は300より大きい値にしてください")
      end
      it "is invalid with price more than 9999999 YEN" do
        item = build(:item, price: "10000000")
        item.valid?
        expect(item.errors[:price]).to include("は9999999より小さい値にしてください")
      end
    end
  end
