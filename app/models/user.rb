class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  #メソッドを持たせる
  attachment :profile_image
         
  enum is_active:{
    effectiveness:        true,    #有効なユーザー
    withdrawn:            false    #退会済みユーザー
   }
  
  has_many :reviews, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  
  #フォローしているユーザーとのアソシエーション
  has_many :relationships, dependent: :destroy
  has_many :followings, through: :relationships, source: :follow
  
  #フォロワーとのアソシエーション  
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "follow_id", dependent: :destroy
  has_many :followers, through: :reverse_of_relationships, source: :user

  #すでにフォローしていればtrueを返す
  def following?(other_user)
    self.followings.include?(other_user)
  end
  
  #ユーザーをフォローする(自分自身をフォローしていないか,重複していないかを検証)
  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end
  
  #フォローがあるか確認し、あればアンフォロー
  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end
  
  #likesテーブルにreview_idが存在するか確認
  def liked_by?(review_id)
    likes.where(review_id: review_id).exists?
  end

end
