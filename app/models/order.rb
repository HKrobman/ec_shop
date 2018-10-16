class Order < ApplicationRecord
    has_many :products
    belongs_to :user
    has_many :cart_items, dependent: :destroy
    PAY_TYPE = ["現金","クレジットカード"]
    
    validates :pay_type, inclusion: PAY_TYPE
    
    def add_items(cart)
	  cart.cart_items.each do |item|
		item.cart_id = nil
		cart_items << item
	  end
    end
	
end
