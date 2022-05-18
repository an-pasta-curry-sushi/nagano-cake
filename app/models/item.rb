class Item < ApplicationRecord
  belongs_to :genre

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: { maximum: 200 }


  has_one_attached :item_image

  def get_item_image
    (item_image.attached?) ? item_image : 'no_image.jpg'
  end
end
