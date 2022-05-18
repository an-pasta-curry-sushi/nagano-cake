class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  varidates :last_name, length: { minimum: 2, maximum: 20 }
  varidates :first_name, length: { minimum: 2, maximum: 20 }
  varidates :last_name_easy, length: { minimum: 2, maximum: 20 }, format: { with: /\A[\p{katakana}\p{blank}ー－]+\z/}
  varidates :first_name_easy, length: { minimum: 2, maximum: 20 }, format: { with: /\A[\p{katakana}\p{blank}ー－]+\z/}
  varidates :phone_number, uniqueness: true
end
