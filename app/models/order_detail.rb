class OrderDetail < ApplicationRecord

  belongs_to :item
  belongs_to :order

  enum making_status: { can_not_making: 0, waiting: 1, making: 2, complete: 3 }

  def sum_of_price
    order_detail.price * order_detail.amount
  end
end
