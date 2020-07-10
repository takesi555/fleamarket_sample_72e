require 'rails_helper'

describe ItemsController ,type: :controller do
  describe 'GET #confirm' do
    before do
      set_user_and_item
    end

    let!(:item){FactoryBot.create(:item)}
    let!(:card){FactoryBot.create(:creditcard)}

    it  "goes to confirm.html.haml" do
      get :confirm, params: {id: @item.id}
      expect(response).to render_template :confirm
    end

    pending "goes to login_path unless login" do
      get:confirm,params: {id: @item.id}
      expect(response).to render_template :index
    end

    pending "goes to new_card_path with no card" do
      user = FactoryBot.build(:user,id:"0")
      get:confirm,params: {id: @item.id}
      expect(response).to render_template :new_card_path
    end

    it "goes to root_path page if the item bought" do
      user = FactoryBot.build(:user,id:"0")
      item = FactoryBot.build(:item,closed_time:Time.now)
      item.save
      get:confirm,params: {id: item.id}
      expect(response).to redirect_to root_path
    end

    it "is collect value in @item" do
      get :confirm, params: {id: @item}
      expect(assigns(:item)).to eq @item
    end

  end

  describe 'POST #purchase' do
    before do
      set_user_and_item
    end

    let!(:card){FactoryBot.create(:creditcard)}

    it "is collect value in @item" do
      post :purchase, params: {id: @item}
      expect(assigns(:item)).to eq @item
    end
    
    pending "goes to login_path unless login" do
      post :purchase, params: {id: @item}
      expect(response).to render_template :login_path
    end

    it "goes root_path if the item bought" do
      item = FactoryBot.build(:item, closed_time:Time.now)
      item.save
      post :purchase, params: {id: item}
      expect(response).to redirect_to root_path
    end
  end

  private

  def set_user_and_item
      @category = build(:category)
      @user = build(:user)
      @category.save
      @user.save
      @item = build(:item)
      @item.save
      
  end
end