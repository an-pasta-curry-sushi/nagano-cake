class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :last_name, length: { minimum: 1, maximum: 15, message: "は1文字以上、20文字以内で入力してください" }
  validates :first_name, length: { minimum: 1, maximum: 15, message: "は1文字以上、20文字以内で入力してください" }
  validates :last_name_easy, length: { minimum: 1, maximum: 15, message: "は1文字以上、20文字以内で入力してください" }, format: { with: /\A[\p{katakana}\p{blank}ー－]+\z/, message: "はカタカナで入力してください"}
  validates :first_name_easy, length: { minimum: 1, maximum: 15, message: "は1文字以上、20文字以内で入力してください" }, format: { with: /\A[\p{katakana}\p{blank}ー－]+\z/,  message: "はカタカナで入力してください"}
  validates :phone_number, uniqueness: true, presence: true
  validates :postal_code, presence: true, format: { with: /\A\d{3}[-]?\d{4}\z/, message: "は数字7桁で入力してください" }
  validates :address, length: { minimum:2, maximum: 100 }

  has_many :deliveries
  has_many :orders
  has_many :cart_items
  has_many :favorites

  def active_for_authentication?
    super && (is_active == true)
  end

  def get_full_name(customer)
    customer.last_name + " " + customer.first_name
  end

end
