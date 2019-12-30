require 'rails_helper'

describe User do
  describe '#create' do
    it "email purposely violation" do
      user = build(:user, email: "asd")
      user.valid?
      expect(user.errors[:email]).to include("is invalid")
    end

    it "is invalid without a email" do
      user = build(:user, email: nil)
      user.valid?
      expect(user.errors[:email]).to include("can't be blank")
    end

    it "multiple email" do
      user = create(:user)
      bad_user = build(:user, email: user.email)
      bad_user.valid?
      expect(bad_user.errors[:email]).to include("has already been taken")
    end

    it "proper email registration" do
      user = create(:user)
      good_another = build(:user, email: "kaneda-san@gmail.com")
      good_another.valid?
      expect(good_another).to be_valid
    end

  end
end