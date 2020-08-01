class CreditcardsController < ApplicationController
  require 'payjp'
  before_action :authenticate_user!
  before_action -> {
    set_payjp_api
  } ,only: [:new,:create,:destroy]

  def show
    if current_user.creditcards.present? then
      @customer = Payjp::Customer.retrieve(current_user.creditcards.first.payjp_custumer_id)
      @cards = @customer.cards
    else
      redirect_to new_creditcard_path,allert: "支払い方法が登録されていません"
    end

  end

  def new
  end

  def create
    if current_user.creditcards.present? then
      @customer = Payjp::Customer.retrieve(current_user.creditcards.first.payjp_custumer_id)
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
        c.user_id = current_user.id
        c.payjp_custumer_id = @customer.id
        c.payjp_card_id = card.id
      end
      redirect_to creditcard_path(current_user.id),notice: "新しいカードを登録しました。"
    rescue => error
      p error
      redirect_to new_creditcard_path,alert: "カードの登録に失敗しました。内容をご確認の上、もう一度お試しください。"
    end

  end
  
  def destroy
    @card = Creditcard.where(payjp_card_id: params[:payjp_card_id]).first
    @customer = Payjp::Customer.retrieve(params[:payjp_customer_id])

    if @customer[:cards][:count] == 1 then
      @customer.delete
    else
      @customer.cards.retrieve(params[:payjp_card_id]).delete
    end

    @card.destroy
    redirect_to creditcard_path,notice: "正常に削除されました"

  end

  private
  def set_payjp_api
    Payjp.api_key = Rails.application.credentials[:PAYJP_SECRET_KEY]
  end

end
