class Destination < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :prefecture, optional: true
  validates :post_code, :city, :block_num, presence: true
  validates :first_name_kana, presence: true, format: { with: /[\p{katakana} ー－&&[^ -~｡-ﾟ]]+/,message: "全角カタカナのみが使用できます。" }
  validates :last_name_kana, presence: true, format: { with: /[\p{katakana} ー－&&[^ -~｡-ﾟ]]+/,message: "全角カタカナのみが使用できます。" }
end
