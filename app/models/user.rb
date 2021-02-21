class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  #ユーザー情報が有効な時true,退会済みユーザのときはfalseが
  enum is_active:{
    effectiveness:        true,
    withdrawn:            false
   }
end
