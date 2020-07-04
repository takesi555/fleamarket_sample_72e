class CreditcardsController < ApplicationController
  def new
  end

  def create
    Payjp.api_key = Rails.application.credentials[:PAYJP_SECRET_KEY]
    binding.pry
    begin
      @customer = Payjp::Customer.create(
        description: 'test'
      )
      
      
    rescue => error
      p error
      redirect_to new_creditcard_path
    end
  end
end
