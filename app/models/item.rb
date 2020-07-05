class Item < ApplicationRecord
  belongs_to :user
  belongs_to :category
  belongs_to :brand
  belongs_to :prefecture
  has_many :itemimages, dependent: :destroy

  with_options presence: true do
    validates :itemimages, presence: true, length: { in: 1..10 }
    validates :name
    validates :description
    validates :category
    validates :condition
    validates :postage
    validates :prefecture
    validates :preparation
    validates :price
    validates :user
    validates :status
  end
end
