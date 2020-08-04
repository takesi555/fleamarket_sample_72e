class ItemsController < ApplicationController
  before_action :authenticate_user!
  before_action -> {
    set_payjp_api
    set_item
  },only: [:confirm,:purchase]

  before_action :move_to_index
  before_action :set_item, only: [:edit, :update]
  before_action :set_show, only: [:show, :destroy]

  def new
    @item = Item.new
    @item.itemimages.build
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path, notice: '商品を出品しました'
    else
      render :new
    end
  end

  def edit
    if @item.user_id != current_user.id
      redirect_to root_path
    end
  end
  
  def show
  end

  def update
    if @item.update(item_params)
      redirect_to root_path, notice: '商品を編集しました'
    else
      render :edit
    end
  end

  def destroy
    if @item.user_id == current_user.id && @item.destroy
      redirect_to user_path(current_user.id), notice: '商品を削除しました'
    end
  end

  def confirm

    if current_user.id == @item.user.id then 
      redirect_to root_path, alert: "自分が出品した商品は購入できません"
      return
    end

    if current_user.creditcards.present? then
      @customer = Payjp::Customer.retrieve(current_user.creditcards.first.payjp_custumer_id)
      @cards = @customer.cards
    else
      redirect_to new_creditcard_path, alert: "支払い方法を登録してください"
      return
    end

    if @item.closed_time.present? then 
      redirect_to root_path, alert: "この商品はすでに購入されています"
      return
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
      @item.buyer_id = current_user.id
      @item.destination_id = params[:destination_id]
      @item.status = 2
      @item.save
      redirect_to complete_item_path
      return
    rescue => error
      p error
      redirect_to confirm_item_path, alert: "購入できませんでした。再度お試しください"
      return
    end
  end

  private

  def set_show
    @item = Item.find(params[:id])
  end

  def set_item
    begin
      @item = Item.find(params[:id])
    rescue
      redirect_to root_path, "購入する商品が見つかりませんでした"
    end
  end

  def set_payjp_api
    Payjp.api_key = Rails.application.credentials[:PAYJP_SECRET_KEY]
  end
  
  def item_params
    params.require(:item).permit(:name, :description, :category_id, :size, :brand_id, :condition_id, :postage_id, :prefecture_id, :preparation_id, :price, itemimages_attributes: [:image, :_destroy, :id]).merge(user_id: current_user.id, status: 1)
  end

  def move_to_index
    redirect_to root_path unless user_signed_in?
  end

  def move_to_login_path
    redirect_to new_user_session_path unless user_signed_in?
  end

end
