class Order < ApplicationRecord

  has_many :order_details
  belongs_to :customer

  enum payment_method: { credit_card: 0, transfer: 1 }
  enum status: { waiting: 0, confirm: 1, making: 2, ready_to_ship: 3, sent: 4 }

  validates :postal_code, presence: true, format: { with: /\A\d{3}[-]?\d{4}\z/ }
  validates :name, length: { minimum: 2, maximum: 20 }
  validates :address, length: { minimum:2, maximum: 100 }
  
  scope :latest, -> {order(created_at: :desc)}

  def sum_of_price
    order_detail.price * order_detail.amount
  end
  
  def get_total_price(cart_items)
    cart_items.each do |cart_item|
      total_price = 0
      total_price += cart_item.item.get_taxin_price * cart_item.amount
    end
    
    return total_price
    
  end

end
