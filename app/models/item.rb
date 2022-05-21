class Item < ApplicationRecord
  belongs_to :genre
  has_many :order_details
  has_many :cart_items

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: { maximum: 200 }

  scope :latest, -> {order(created_at: :desc)}

  has_one_attached :item_image

  def get_item_image
    (item_image.attached?) ? item_image : 'no_image.jpg'
  end

  def get_taxin_price
    tax = 1.1
    taxin_price = no_tax_price * tax
    return taxin_price.round
  end


  def sum_of_price(cart_item)
    
    cart_item.item.get_taxin_price * cart_item.amount
    
  end
  
  def get_total_price(cart_items)
    cart_items.each do |cart_item|
      total_price = 0
      total_price += (cart_item.item.get_taxin_price * amount)
    end
    
    return total_price
    
  end

end
