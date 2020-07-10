class CreditcardsController < ApplicationController
  require 'payjp'
    # if not user_signedin? then redirect_to login_path
  before_action -> {
    set_payjp_api
    set_user
  } ,only: [:new,:create,:destroy]

  def new
  end

  def create
    # サインイン情報取得可能になった後以下を代わりに使用
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
    @card = Creditcard.find(params[:id])
    @customer = Payjp::Customer.retrieve(@card.payjp_custumer_id)

    if @customer[:data][:count] = 1 then
      @customer.delete
    else
      @customer.card.retrieve(@card.payjp_card_id).delete
    end

    @card.destroy

  end

  private
  def set_payjp_api
    Payjp.api_key = Rails.application.credentials[:PAYJP_SECRET_KEY]
  end

  def set_user
    # ログイン機能実装後以下を使用
    # @user = current_user
    @user = User.find(1)
  end
end
