FactoryBot.define do
  factory :item do
    id              {1}
    name            {"タンス"}
    description      {"かわいいよ"}
    condition            {"非常に良い"}
    cover_postage        {"着払い"}
    prefectures              {"北海道"}
    shipping_date            {"入金から３日以内"}
    category           {"家具"}
    price              {3333}
    profit_price       {3333}
    margin_price       {3333}
    seller_id          {5}   
  end
end
