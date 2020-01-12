FactoryBot.define do
  factory :address do
    postal_code { "111-1111" }
    prefectures { 1 }
    city { "豊島区" }
    address { "三角町1-1-1" }
  end
end
