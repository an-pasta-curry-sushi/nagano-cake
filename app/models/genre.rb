class Genre < ApplicationRecord
  has_many :items

  validates :name, length: { minimum: 1, maximum: 10 }, uniqueness: true
end