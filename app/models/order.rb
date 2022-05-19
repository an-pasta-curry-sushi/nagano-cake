class Order < ApplicationRecord

  has_many :order_details
  belongs_to :customer

  enum payment_method: { credit_card: 0, transfer: 1 }
  
  def sum_of_price
    order_detail.price * order_detail.amount
  end
end
