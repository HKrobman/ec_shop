class Stock < ApplicationRecord
    belongs_to :product
    
    validates :product_id, :quantity, :sales_quantity, presence: true
end
