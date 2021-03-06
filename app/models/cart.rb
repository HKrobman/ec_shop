class Cart < ApplicationRecord
    
  has_many :cart_items, dependent: :destroy
  has_many :products, through: :cart_items
  
  validates :user_id, presence: true

  #productページの数量ボックスから個数を選択した場合の処理
   def add_product(product_id, quantity)
     current_items = cart_items.find_by_product_id(product_id)
     if current_items
       current_items.quantity += quantity
     else
       current_items = cart_items.build(product_id: product_id)
       current_items.quantity += quantity
     end
     current_items
   end
   
 #cartページの数量ボックスから個数を変更した場合の処理
  def change_count(product_id, quantity)
    current_items = cart_items.find_by_product_id(product_id)
    current_items.quantity = quantity
    current_items
  end

  #カート内商品の合計
  def total_price
    cart_items.to_a.sum{ |item| item.total_price }
  end
  
end
