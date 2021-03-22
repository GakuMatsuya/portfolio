#reviewモデルテストに使用するデータの生成
FactoryBot.define do
  factory :review do
    rate { 1 }
    text { Faker::Lorem.characters(number:100) }
    association :user
    association :item
  end
end