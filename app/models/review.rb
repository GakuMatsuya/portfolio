class Review < ApplicationRecord
  
  belongs_to :user
  
  #レートを1以上5以下設定
  validates :rate, numericality: {
    less_than_or_equal_to: 5,
    greater_than_or_equal_to: 1
  }, presence: true

end
