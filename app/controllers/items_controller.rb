class ItemsController < ApplicationController
  require 'payjp'

  def new
    @item = Item.new
  end

  def create
  end

  def confirm
  end

  def purchase
    Payjp.api_key = "sk_secretkey"
    begin
      @customer = Payjp::Customer.retrieve("cus_a9fe173905e3134a8ea2f3f69540")
      
      @charge = Payjp::Charge.create(
        amount: 1000,
        customer: @customer[:id],
        card: @customer[:default_card],
        currency: 'jpy',
      )
      
    rescue => error
      p error
      redirect_to confirm_item_path
    end
  end
    
end
