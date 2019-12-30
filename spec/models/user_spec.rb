require 'rails_helper'
describe User do
  describe '#create' do
    it "email purposely violation" do
      user = User.new(email: "abcdefg12345")
      user.valid?
      expect(user.errors[:email]).to include("email should contains @")
    end
  end
end