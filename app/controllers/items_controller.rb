class ItemsController < ApplicationController
  require 'payjp'

  def new
    @item = Item.new
  end

  def create
  end

  def confirm
    # ログイン機能実装後以下を使用
    # unless user_signed_in? redirect_to login_path
    # @user = current_user
    #@itemは商品詳細ページから取得するidをもとに作成
    @user = User.where(id="1").first
    @item = Item.where(id="2").first
    # サインイン情報取得可能になった後以下を代わりに使用
    # if current_user.creditcards.present? then
    # @customer = Payjp::Customer.retrieve(current_user.credicards.first)
    if User.find(id="2").creditcards.present? then
      @customer = Payjp::Customer.retrieve(@user.creditcards.first.payjp_customer_id)
      @cards = @customer.cards
    else
      redirect_to new_creditcard_path  
    end
  end

  def purchase
    Payjp.api_key = Rails.application.credentials[:PAYJP_SECRET_KEY]
    binding.pry
    begin
      
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
