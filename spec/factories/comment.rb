#commentモデルテストに使用するデータの生成
FactoryBot.define do
  factory :comment do
    text { Faker::Lorem.characters(number:100) }
    association :review
    association :user
  end
end