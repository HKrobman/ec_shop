class Mylist < ApplicationRecord
    belongs_to :user
    belongs_to :product
    default_scope -> {order('created_at DESC')}
    validates :user_id, :product_id, presence: true
end
