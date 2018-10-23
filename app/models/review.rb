class Review < ApplicationRecord
    belongs_to :product
    belongs_to :user
    
    validates :name, :title, :description, presence: true
    validates :title, length: {maximum: 50}
    validates :description, length: {maximum: 300}
end
