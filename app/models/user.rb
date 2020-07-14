class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable,  :validatable, password_length: 7..128
  
  
  has_many :buyer_product, foreign_key: "buyer_id", class_name: "product", dependent: :destroy

  validates :nickname, :password, :email, :last_name, :first_name, :ruby_last_name, :ruby_first_name, :birthdate, presence: true
  has_many :products, dependent: :destroy
  has_one :ship_address, dependent: :destroy
  has_one :credit_card, dependent: :destroy
end