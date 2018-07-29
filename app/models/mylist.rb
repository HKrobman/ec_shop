class Mylist < ApplicationRecord
    belongs_to :user
    has_many :products
    default_scope -> {order('created_at DESC')}
    validates :user_id, presence: true
end
