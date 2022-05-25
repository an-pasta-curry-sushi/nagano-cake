class Delivery < ApplicationRecord

  belongs_to :customer

  validates :postal_code, presence: true, format: { with: /\A\d{3}[-]?\d{4}\z/ , message: "は数字7桁で入力してください"}
  validates :name, length: { minimum: 1, maximum: 31 }
  validates :address, length: { minimum:2, maximum: 100 }

  def address_display
  '〒' + postal_code + ' ' + address
  end

end
