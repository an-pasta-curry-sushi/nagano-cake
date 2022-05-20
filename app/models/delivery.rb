class Delivery < ApplicationRecord

  belongs_to :customer

  VALID_POSTAL_CODE_REGEX = /\A\d{3}[-]?\d{4}\z/
  validates :postal_code, presence: true, format: { with: VALID_POSTAL_CODE_REGEX }
  validates :name, length: { minimum: 2, maximum: 20 }
  validates :address, length: { minimum:2, maximum: 100 }

end
