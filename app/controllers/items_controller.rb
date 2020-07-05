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
    Payjp.api_key = Rails.application.credentials[:PAYJP_SECRET_KEY]
    binding.pry
    begin
      @customer = Payjp::Customer.retrieve("cus_4645fa1ce36409e3db5543e179e8")
      
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
