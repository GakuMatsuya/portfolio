class Comment < ApplicationRecord
  
  validates :text, presence: true
  
  belongs_to :user
  belongs_to :review

  #コメントを降り順で表示
  default_scope -> { order(created_at: :desc) }

end
