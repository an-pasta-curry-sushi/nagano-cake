class Genre < ApplicationRecord
  has_many :items

  validates :name, length: { minimum: 1, maximum: 20 }, uniqueness: true
end
