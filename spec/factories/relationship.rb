FactoryBot.define do
  factory :relationship do
    follower_id { 1 }
    following_id { 2 }
    association :following, factory: :user
    association :follower, factory: :user
  end
end