class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item
  before_action :move_to_index

  def index
    @order = PayForm.new
  end

  def create
    @order = PayForm.new(order_params)
    if @order.valid?
      pay_item
      @order.save
      redirect_to root_path
    else
      render 'index'
    end

  end

  private

  def order_params
    params.require(:pay_form).permit(
      :postal_code,
      :prefecture_id,
      :city,
      :address,
      :building,
      :phone_number
      ).merge(user_id: current_user.id,item_id: params[:item_id] , token: params[:token])
  end

  def pay_item 
    Payjp.api_key = "sk_test_d11cda623508485e26a9f04f" #環境変数と合わせましょう
    Payjp::Charge.create(
      amount: @item.price, # 決済額
      card: order_params[:token], # カード情報
      currency: 'jpy' # 通貨単位
    )
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def move_to_index
    return redirect_to root_path if current_user.id == @item.user.id
  end
end