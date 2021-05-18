class PayForm
  include ActiveModel::Model
  attr_accessor  :postal_code, :prefecture_id, :city, :address, :building, :phone_number, :user_id ,:item_id ,:token

  # <<バリデーション>>
  with_options presence: true do
  validates :postal_code, format: { with: /\A\d{3}[-]\d{4}\z/}
  validates :prefecture_id, numericality: { other_than: 0 }
  validates :city
  validates :address
  validates :phone_number
  validates :user_id
  validates :item_id 
  validates :token #追加

 end

 def save
  order = Order.create(
    #保存した情報を変数orderにいれる
    item_id: item_id,
    user_id: user_id
  )

  Address.create(
    order_id: order.id,
    #保存された情報を持つ変数orderから、idだけを取り出し、order_idとして保存を行う
    postal_code: postal_code,
    prefecture_id: prefecture_id,
    city: city,
    address: address,
    building: building,
    phone_number: phone_number
  )
 end

end