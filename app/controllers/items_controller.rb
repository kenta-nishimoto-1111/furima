class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
 # deviseのヘルパーメソッド。ログインしていなければ、ログイン画面へ遷移させる。
 before_action :set_item, only:[ :show , :edit , :update ] # 追加
 before_action :move_to_index, only:[ :edit , :update ] # 追加

  def index
    @items = Item.includes(:user).order("created_at DESC")
  end

  def new
    # form_withで使用するために設定する
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    # バリデーションで問題があれば、保存はされず「商品出品画面」を再描画
    if @item.save
      return redirect_to root_path
    end
    # アクションのnewをコールすると、エラーメッセージが入った@itemが上書きされてしまうので注意しましょう。
    render 'new'
  end

  def show
  end

  def edit
  end
  
  def update
    @item.update(item_params)
    if @item.valid?
      redirect_to item_path(@item)
    else
      render 'edit'
    end
  end

  private

  def item_params
    params.require(:item).permit(
      :image,
      :name,
      :info,
      :category_id,
      :sales_status_id,
      :shipping_fee_status_id,
      :prefecture_id,
      :scheduled_delivery_id,
      :price
    ).merge(user_id: current_user.id)
  # ストロングパラメーターの設定も受講生によって名前が異なります。
  # ActiveHashの設定を確認しましょう。
  end

  def set_item  # 追加
    @item = Item.find(params[:id])
  end
  
  def move_to_index # 追加
    return redirect_to root_path if current_user.id != @item.user.id
  end

end