class CartItem < ApplicationRecord
  belongs_to :product
  belongs_to :cart
  belongs_to :order, optional: true  #rails5からの挙動
  
 #商品毎の合計
  def total_price
    product.sale_price * quantity
  end
end
