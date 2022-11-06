FactoryBot.define do
  factory :employee do
    number { "999999" }
    last_name { "hoge" }
    first_name { "hogehoge" }
    account { "hoge" }
    password { "password" }
    email { "hoge@example.co.jp" }
    date_of_joining { 2022-11-30 }
    association :office
  end
end
