class ItemsController < ApplicationController
  require 'payjp'

  def new
    @item = Item.new
  end

  def create
  end

  def confirm
    Payjp.api_key = Rails.application.credentials[:PAYJP_SECRET_KEY]

    # ログイン機能実装後以下を使用
    # unless user_signed_in? redirect_to login_path
    # @user = current_user
    @user = User.where(id:"1").first
    @item = Item.find(params[:id])
    # サインイン情報取得可能になった後以下を代わりに使用
    # if current_user.creditcards.present? then
    # @customer = Payjp::Customer.retrieve(current_user.credicards.first)
    if @user.creditcards.present? then
      @customer = Payjp::Customer.retrieve(@user.creditcards.first.payjp_customer_id)
      @cards = @customer.cards
    else
      redirect_to new_creditcard_path  
    end

    if @item.closed_time.present? then 
      redirect_to root_path
    end
  end

  def purchase
    Payjp.api_key = Rails.application.credentials[:PAYJP_SECRET_KEY]
    @item = Item.find(params[:id])
    @user = User.where(id:"2").first
    # current_user使用できるようになったら以下に切り替え
    # @user = current_user.id
    # unless user_signed_in? redirect_to login_path
    if @item.closed_time.present? then
      redirect_to root_path
      return
    end
    
    begin
      @charge = Payjp::Charge.create(
        amount: @item.price,
        customer: params[:payjp_customer_id],
        card: params[:payjp_card_id],
        currency: 'jpy',
      )
      binding.pry
      @item.closed_time = Time.now
      @item.buyer_id = @user.id
      @item.save
    rescue => error
      p error
      redirect_to confirm_item_path
    end
  end
    
end
