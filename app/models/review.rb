class Review < ApplicationRecord

  belongs_to :user
  belongs_to :item
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  #レートを0.5以上5以下に設定
  validates :rate, numericality: {
    less_than_or_equal_to: 5,
    greater_than_or_equal_to: 0.5
  }, presence: true

  validates :text, presence: true

  #投稿を降り順で表示
  default_scope -> { order(created_at: :desc) }

end
