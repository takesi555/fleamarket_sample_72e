class Prefecture < ApplicationRecord
  has_many :destinations
  has_many :items

end