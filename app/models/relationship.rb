class Relationship < ApplicationRecord
  
  #自分をフォローしているユーザー
  belongs_to :follower, class_name: "User"

  #自分がフォローしている
  belongs_to :following, class_name: "User"
  
  #両方のidが揃っていないと保存されないように設定
  validates :follower_id, :following_id, presence: true
end