class Order < ApplicationRecord
    has_many :products
    belongs_to :user
    has_many :cart_items, dependent: :destroy
    
    validates :pay_type, presence: true
    PAY_TYPE = ["現金","クレジットカード"]
end
