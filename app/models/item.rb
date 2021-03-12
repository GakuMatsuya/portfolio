class Item < ApplicationRecord
  belongs_to :genre
  has_many :reviews, dependent: :destroy
  attachment :image
  
  validates :genre_id, :name, :image, :introduction, presence: true 
end
