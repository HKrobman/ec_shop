class Product < ApplicationRecord
    belongs_to :category
    has_many :reviews
    attr_accessor :image_url  
    mount_uploader :image_url, ImageUploader
    
    validates :name, :category_id,:company,:released_on,:code,:list_price,:sale_price,:description,:image_url,:delivery_days,:active,:color, presence: true
end
