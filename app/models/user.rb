class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  enum is_active:{
    effectiveness:        true,    #有効なユーザー
    withdrawn:            false    #退会済みユーザー
   }
end
