class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :last_name, length: { minimum: 2, maximum: 20 }
  validates :first_name, length: { minimum: 2, maximum: 20 }
  validates :last_name_easy, length: { minimum: 2, maximum: 20 }, format: { with: /\A[\p{katakana}\p{blank}ー－]+\z/}
  validates :first_name_easy, length: { minimum: 2, maximum: 20 }, format: { with: /\A[\p{katakana}\p{blank}ー－]+\z/}
  validates :phone_number, uniqueness: true
  validates :postal_code, presence: true, format: { with: /\A\d{3}[-]?\d{4}\z/ }
  validates :address, length: { minimum:2, maximum: 100 }

  has_many :deliveries
  has_many :orders
  has_many :cart_items

  def active_for_authentication?
    super && (is_active == true)
  end

  def get_full_name(customer)
    customer.last_name + " " + customer.first_name
  end

end
