class Creditcard < ApplicationRecord
  belongs_to :user

  validates :user_id,:payjp_customer_id,:payjp_card_id, presence: true
end
