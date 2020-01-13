require 'rails_helper'

describe Address do
  describe '#create' do
    #1,prefectures,city, address, postal_codeが存在すれば登録できること
    it "is valid with a prefectures,city, address, postal_code" do
      address = build(:address)
      expect(address).to be_valid
  end

    # 2. prefecturesが空では登録できないこと
    it "is invalid without a prefectures" do
      address = build(:address, prefectures: nil)
      address.valid?
      expect(address.errors[:prefectures]).to include("を入力してください")
    end

    # 3. cityが空では登録できないこと
    it "is invalid without a city" do
      address = build(:address, city: nil)
      address.valid?
      expect(address.errors[:city]).to include("を入力してください")
    end

    # 4. addressが空では登録できないこと
    it "is invalid without a address" do
      address = build(:address, address: nil)
      address.valid?
      expect(address.errors[:address]).to include("を入力してください")
    end
    
    #5. postal_codeが空では登録できないこと
    it "is invalid without a postal_code" do
      address = build(:address, postal_code: nil)
      address.valid?
      expect(address.errors[:postal_code]).to include("を入力してください")
    end

    # 6. postal_codeがハイフンあり7桁であれば登録できること
    it "is valid with a postal_code 3桁-４桁 " do
      address = build(:address, postal_code: "1234567")
      address.valid?
      expect(address.errors[:postal_code]).to include("はハイフンを入れて半角英数字で入力してください")
    end
  end
end
