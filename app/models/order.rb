class Order < ApplicationRecord
    has_many :products,through: :cart_items
    belongs_to :user
    has_many :cart_items, dependent: :destroy
    PAY_TYPE = ["現金","クレジットカード"]
    
    validates :pay_type, presence: true, inclusion: PAY_TYPE
    validates :addressee_name_kana, presence: true
    validates :addressee_name_kanji, presence: true
    validates :addressee_zip_code, presence: true
    validates :addressee_prefecture, presence: true
    validates :addressee_city, presence: true
    validates :addressee_address1, presence: true
    validates :addressee_address2, presence: true
    
    def add_items(cart)
	  cart.cart_items.each do |item|
		item.cart_id = nil
		cart_items << item
	  end
    end
end
