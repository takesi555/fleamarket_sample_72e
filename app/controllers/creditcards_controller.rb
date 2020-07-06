class CreditcardsController < ApplicationController
  require 'payjp'
    # if not user_signedin? then redirect_to login_path

  def new
    
    @user = User.where(id="2")
    # ログイン機能実装後以下を使用
    # @user = current_user
  end

  def create
    Payjp.api_key = Rails.application.credentials[:PAYJP_SECRET_KEY]
    # サインイン情報取得可能になった後以下を代わりに使用
    # @customer = Payjp::Customer.retrieve(current_user.credicards.first)
    if User.find(id='2').creditcards.present? then
      @customer = Payjp::Customer.retrieve(User.find(id="1").creditcards.first.payjp_customer_id)
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
        # [TODO]ログインしているuserモデルからサインイン情報抜き出し
        c.user_id = '1'
        c.payjp_customer_id = @customer.id
        c.payjp_card_id = card.id
      end
      redirect_to root_path
    rescue => error
      p error
      redirect_to new_creditcard_path
    end

  end
end
