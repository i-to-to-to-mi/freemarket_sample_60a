FactoryBot.define do
  factory :address do
    postal_code { 1 }
    Prefectures { "MyString" }
    city { "MyString" }
    address1 { "MyString" }
    address2 { "MyString" }
    address_phone_number { 1 }
  end
end
