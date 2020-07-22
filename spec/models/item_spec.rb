require 'rails_helper'

# RSpec.describe Item, type: :model do
#   pending "add some examples to (or delete) #{__FILE__}"
# end

describe Item do
  describe '#create' do

    it "データが全て存在すれば登録できること" do
      item = FactoryBot.build(:item)
      item.valid?
      expect(item).to be_valid
    end

    it "出品画像が無いと登録できないこと" do
      image = FactoryBot.build(:itemimage, image: nil)
      image.valid?
      expect(image.errors[:image]).to include("を入力してください")
    end
  
    it "商品名が無いと登録できないこと" do
      item = FactoryBot.build(:item, name: nil)
      item.valid?
      expect(item.errors[:name]).to include("を入力してください")
    end

    it "商品の概要が無いと登録できないこと" do
      item = FactoryBot.build(:item, description: nil)
      item.valid?
      expect(item.errors[:description]).to include("を入力してください")
    end

    it "カテゴリーが無いと登録できないこと" do
      item = FactoryBot.build(:item, category: nil)
      item.valid?
      expect(item.errors[:category]).to include("を入力してください")
    end

    it "サイズが無いと登録できないこと" do
      item = FactoryBot.build(:item, size: nil)
      item.valid?
      expect(item.errors[:size]).to include("を入力してください")
    end

    it "ブランドが無くても登録できること" do
      item = FactoryBot.build(:item, brand: nil)
      item.valid?
      expect(item).to be_valid
    end

    it "商品の状態が無いと登録できないこと" do
      item = FactoryBot.build(:item, condition: nil)
      item.valid?
      expect(item.errors[:condition]).to include("を入力してください")
    end

    it "配送料の負担が無いと登録できないこと" do
      item = FactoryBot.build(:item, postage: nil)
      item.valid?
      expect(item.errors[:postage]).to include("を入力してください")
    end

    it "発送元の地域が無いと登録できないこと" do
      item = FactoryBot.build(:item, prefecture: nil)
      item.valid?
      expect(item.errors[:prefecture]).to include("を入力してください")
    end

    it "発送までの日数が無いと登録できないこと" do
      item = FactoryBot.build(:item, preparation: nil)
      item.valid?
      expect(item.errors[:preparation]).to include("を入力してください")
    end

    it "販売価格が無いと登録できないこと" do
      item = FactoryBot.build(:item, price: nil)
      item.valid?
      expect(item.errors[:price]).to include("を入力してください")
    end

    it "販売価格が299円以下だと登録できないこと" do
      item = FactoryBot.build(:item, price: 299)
      item.valid?
      expect(item.errors[:price]).to include("は300以上の値にしてください")
    end

    it "販売価格が10000000円以下だと登録できないこと" do
      item = FactoryBot.build(:item, price: 10000000)
      item.valid?
      expect(item.errors[:price]).to include("は10000000より小さい値にしてください")
    end

  end
end