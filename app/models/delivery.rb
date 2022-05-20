class Delivery < ApplicationRecord

  belongs_to :customer

  validates :postal_code, presence: true, format: { with: /\A\d{3}[-]?\d{4}\z/ }
  validates :name, length: { minimum: 2, maximum: 20 }
  validates :address, length: { minimum:2, maximum: 100 }

  def address_display
  '〒' + postal_code + ' ' + address + ' ' + name
  end

end
