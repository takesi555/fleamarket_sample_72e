require 'rails_helper'

RSpec.describe Creditcard, type: :model do

  describe '#create' do
    it "can register a card" do
      user = User.find(1)
      card = Creditcard.new(user_id:user.id,payjp_customer_id:"cus_0000000000000000",payjp_card_id:"car_000000000000000000")
      expect(card).to be_valid
    end
    it "can't register a card if no user" do
      card = Creditcard.new(user_id:"0",payjp_customer_id:"cus_0000000000000000",payjp_card_id:"car_000000000000000000")
      card.valid?
      expect(card.errors[:user]).to include("must exist")
    end
    it "can't register a card if no customer_id" do
      user = User.find(1)
      card = Creditcard.new(user_id:user.id,payjp_customer_id:"",payjp_card_id:"car_000000000000000000")
      card.valid?
      expect(card.errors[:payjp_customer_id]).to include("can't be blank")
    end
    it "can't register a card if no card_id" do
      user = User.find(1)
      card = Creditcard.new(user_id:user.id,payjp_customer_id:"cus_0000000000000000",payjp_card_id:"")
      card.valid?
      expect(card.errors[:payjp_card_id]).to include("can't be blank")
    end


    it "can delete a card" do
    end
    it "can delete a card if the owner deleted" do
    end
    it "can redirect to toppage if it's purchase succsess" do
    end
    it "can't register if the card is invalid" do
    end
    it "can't purchase if no cards registerd" do
    end
  end
end
