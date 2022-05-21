class CartItem < ApplicationRecord
  belongs_to :customer
  belongs_to :item

  def sum_of_price
    item.get_taxin_price * amount
  end

end
