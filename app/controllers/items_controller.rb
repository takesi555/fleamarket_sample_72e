class ItemsController < ApplicationController
  before_action :move_to_login_path
  before_action -> {
    set_payjp_api
    set_user
    set_item
  },only: [:confirm,:purchase]


  def new
    @item = Item.new
    @item.itemimages.build
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
      # フラッシュメッセージを利用する場合は、以下に置き換え
      # redirect_to root_path, notice: '商品を出品しました'
    else
      render :new
      @item = Item.new(item_params)
      @item.itemimages.build
    end
  end

  def confirm

    if @user.id == @item.user.id then 
      redirect_to root_path, alert: "自分が出品した商品は購入できません"
    end

    if current_user.creditcards.present? then
      @customer = Payjp::Customer.retrieve(current_user.creditcards.first.payjp_custumer_id)
      @cards = @customer.cards
    else
      redirect_to new_creditcard_path, alert: "支払い方法を登録してください"
    end

    if @item.closed_time.present? then 
      redirect_to root_path, alert: "この商品はすでに購入されています"
    end
  end

  def purchase

    if @item.closed_time.present? then
      redirect_to root_path, alert: "この商品はすでに購入されています"
      return
    end
    
    begin
      @charge = Payjp::Charge.create(
        amount: @item.price,
        customer: params[:payjp_customer_id],
        card: params[:payjp_card_id],
        currency: 'jpy',
      )
      @item.closed_time = Time.now
      @item.buyer_id = @user.id
      @item.destination_id = params[:destination_id]
      @item.save
      redirect_to root_path, notice: "商品は正常に購入されました"
    rescue => error
      p error
      redirect_to confirm_item_path, alert: "購入できませんでした。再度お試しください"
    end
  end

  private
  def set_item
    begin
      @item = Item.find(params[:id])
    rescue
      redirect_to root_path, "購入する商品が見つかりませんでした"
    end
  end

  def set_user
    @user = current_user
  end

  def set_payjp_api
    Payjp.api_key = Rails.application.credentials[:PAYJP_SECRET_KEY]
  end
  
  def item_params
    params.require(:item).permit(:name, :description, :category_id, :size, :brand_id, :condition_id, :postage_id, :prefecture_id, :preparation_id, :price, itemimages_attributes: [:image]).merge(user_id: current_user.id, status: 1)
  end

  def move_to_index
    redirect_to root_path unless user_signed_in?
  end

  def move_to_login_path
    redirect_to new_user_session_path unless user_signed_in?
  end

end
