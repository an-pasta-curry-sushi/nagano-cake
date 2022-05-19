class OrderDetail < ApplicationRecord

  belongs_to :item
  belongs_to :order

  def sum_of_price
    order_detail.price * order_detail.amount
  end
end
