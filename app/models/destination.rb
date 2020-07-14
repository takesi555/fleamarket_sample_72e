class Destination < ApplicationRecord
  belongs_to :user
  belongs_to :prefecture
  has_many :destinations
end
