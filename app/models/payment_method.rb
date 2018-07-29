class PaymentMethod < ApplicationRecord
    belongs_to :user
    validates :name, presence: true
    validates :payment_method, presence: true
    validates :card_number, presence: true
    validates :security_code, presence: true
    validates :period, presence: true
end
