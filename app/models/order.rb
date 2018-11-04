class Order < ApplicationRecord
    has_many :products,through: :cart_items
    belongs_to :user
    has_many :cart_items, dependent: :destroy
    PAY_TYPE = ["現金","クレジットカード"]
    
    #validates :pay_type, presence: true, inclusion: PAY_TYPE
    validates :addressee_name_kana, presence: true, format: { with: /\A[\p{katakana}\p{blank}ー－]+\z/, message: 'はカタカナで入力して下さい。'}
    validates :addressee_name_kanji, presence: true
    validates :order_telphone, presence: true, uniqueness: true
    validates :addressee_zip_code, presence: true
    validates :addressee_prefecture, presence: true
    validates :addressee_city, presence: true
    validates :addressee_address1, presence: true
    
    default_scope -> {order('created_at DESC')}
    
    validate :add_error_sample
    def add_error_sample
      if pay_type.empty?
        errors[:base] << "お支払い方法を選択して下さい"
      end
    end
    
    def add_items(cart)
	  cart.cart_items.each do |item|
		item.cart_id = nil
		cart_items << item
	  end
    end
end
