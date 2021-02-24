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
  
  #フォローしている人を取得するための記述
  has_many :relationships, dependent: :destroy
  
  #followingsクラスを仮で指定。relationshipテーブルのfollow_idから、フォローしている人たちを取得
  has_many :followings, through: :relationships, source: :follow
  
  #フォロワーを取得する記述
  #reverse_of_relationshipsというクラスを仮で指定。relationsipテーブルのfollow_idを基に、アクセス
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "follow_id", dependent: :destroy

  #先ほど指定したreberse_of_relationshipsを中間テーブルとし、フォロワーのuser_idを取得する
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
    if !relationship.empty?
      relationship.destroy
    end
  end

end
