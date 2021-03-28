class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable             #omniauthを有効化
  attachment :profile_image

  enum is_active:{
    effectiveness:        true,    #有効なユーザー
    withdrawn:            false    #退会済みユーザー
   }

  validates :name, presence: true

  has_many :reviews, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  #likesテーブルを通して、reviewの情報を取ってくる
  has_many :liked_reviews, through: :likes, source: :review


  #フォローしているユーザーとのアソシエーション
  has_many :following_relationships, foreign_key: "follower_id", class_name: "Relationship", dependent: :destroy
  has_many :following, through: :following_relationships

  #フォロワーとのアソシエーション
  has_many :follower_relationships, foreign_key: "following_id", class_name: "Relationship", dependent: :destroy
  has_many :followers, through: :follower_relationships

  #フォローしているか確認
  def following?(user)
    following_relationships.find_by(following_id: user.id)
  end

  #ユーザーをフォローする
  def follow(user)
    following_relationships.create!(following_id: user.id)
  end


  #フォローを外す
  def unfollow(user)
    following_relationships.find_by(following_id: user.id).destroy
  end

  #likesテーブルにreview_idが存在するか確認
  def liked_by?(review_id)
    likes.where(review_id: review_id).exists?
  end

  #有効なユーザの場合trueを返す
  def active_for_authentication?
    super && (self.is_active == "effectiveness")
  end

  #認証情報のemailがDBにあれば最初のユーザーを返す。なければ作成
  def self.from_omniauth(auth)
    user = User.where(email: auth.info.email).first

    unless user
      user = User.create(name: auth.info.name,
                         provider: auth.provider,
                         uid: auth.uid,
                         email: auth.info.email,
                         token: auth.credentials.token,
                         password: Devise.friendly_token[0,20])
    end
    user
  end
end