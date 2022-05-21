class CartItem < ApplicationRecord
  belongs_to :customer
  belongs_to :item

  def sum_of_price
    item.get_taxin_price * amount
  end
  
  def get_total_price(cart_items)
    
    cart_items.each do |cart_item|
      
      total_price = 0
      total_price += cart_item.item.get_taxin_price * amount
      
    end
    
    return total_price
    
  end

end
