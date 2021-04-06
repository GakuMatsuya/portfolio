# itemモデルテストに使用するデータの生成
FactoryBot.define do
  factory :item do
    name { Faker::Name.name }
    image_id { Faker::Lorem.characters(number: 20) }
    introduction { Faker::Lorem.characters(number: 50) }
    association :genre
  end
end
