class Item < ApplicationRecord
  belongs_to :user
  belongs_to :category
  belongs_to :brand
  belongs_to :prefecture
  has_many :itemimages, dependent: :destroy
  accepts_nested_attributes_for :itemimages, allow_destroy: true
  
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :condition
  belongs_to_active_hash :postage
  belongs_to_active_hash :preparation
  
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
