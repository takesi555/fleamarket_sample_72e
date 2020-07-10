class CreditcardsController < ApplicationController
  require 'payjp'
    # if not user_signedin? then redirect_to login_path

  def new
    
    @user = User.find(2)
    # ログイン機能実装後以下を使用
    # @user = current_user
  end

  def create
    Payjp.api_key = Rails.application.credentials[:PAYJP_SECRET_KEY]
    @user = User.find(2)
    # サインイン情報取得可能になった後以下を代わりに使用
    # @user = current_user
    # if current_user.creditcards.present? then
    # @customer = Payjp::Customer.retrieve(current_user.credicards.first)
    if @user.creditcards.present? then
      @customer = Payjp::Customer.retrieve(@user.creditcards.first.payjp_custumer_id)
    else
      @customer = Payjp::Customer.create()
    end

    begin
      card = @customer.cards.create(
        card: params[:token]
      )
      card.name = params[:name]
      card.save
      Creditcard.create do |c|
        c.user_id = @user.id
        c.payjp_custumer_id = @customer.id
        c.payjp_card_id = card.id
      end
      redirect_to root_path
    rescue => error
      p error
      redirect_to new_creditcard_path
    end

  end
  
  def destroy
    Payjp.api_key = Rails.application.credentials[:PAYJP_SECRET_KEY]
    @card = Creditcard.find(params[:id])
    @customer = Payjp::Customer.retrieve(@card.payjp_custumer_id)

    if @customer[:data][:count] = 1 then
      @customer.delete
    else
      @customer.card.retrieve(@card.payjp_card_id).delete
    end

    @card.destroy

  end
end
