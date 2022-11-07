FactoryBot.define do
  factory :article do
    title { "hoge" }
    content { "hogehoge" }
    association :employee
  end
end
