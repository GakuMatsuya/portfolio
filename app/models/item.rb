class Item < ApplicationRecord
  belongs_to :genre
  has_many :reviews, dependent: :destroy
  attachment :image

  validates :genre, :name, :image, :introduction, presence: true
  
  # レビューがあれば平均値を取得、なければ0を取得
  def review_average
    return 0 if reviews.blank?
    reviews.average(:rate).round(1)
  end

end