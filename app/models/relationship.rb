class Relationship < ApplicationRecord
  
  belongs_to :user

  #userクラスにbelongs_toするよう、補足設定
  belongs_to :follow, class_name: "User"
  
  #両方のidが揃っていないと保存されないように設定
  validates :user_id, presence: true
  validates :follow_id, presence: true

end
