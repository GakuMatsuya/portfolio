class Review < ApplicationRecord

  belongs_to :user
  belongs_to :item
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  #レートを1以上5以下に設定
  validates :rate, numericality: {
    less_than_or_equal_to: 5,
    greater_than_or_equal_to: 1
  }, presence: true

end
