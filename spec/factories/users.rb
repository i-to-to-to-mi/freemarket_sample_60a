FactoryBot.define do

  factory :user do
    first_name            {"abe"}
    first_name_kana       {"アベ"}
    last_name             {"abe"}
    last_name_kana        {"アベ"}
    nickname              {"abe"}
    birth_year            {2020}
    birth_month           {1}
    birth_day             {1}
    email                 {"kkk@email.com"}
    password              {"00000000"}
    password_confirmation {"00000000"}
  end
end

  
# FactoryBot.define do

#   factory :user do
#     first_name            {"かね"}
#     first_name_kana       {"かね"}
#     last_name             {"かね"}
#     last_name_kana        {"かね"}
#     nickname              {"かねやん"}
#     birth_year            {2000}
#     birth_month           {10}
#     birth_day             {15}
#     email                 {"kaneyan@email.com"}
#     password              {"00000000"}
#     password_confirmation {"00000000"}
#   end
# end