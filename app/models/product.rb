class Product < ApplicationRecord
    belongs_to :category
    has_many :mylists
    has_many :users, through: :mylists
    has_many :reviews
    
    has_many :cart_items, dependent: :destroy
    has_many :carts, through: :cart_items
    
    has_many :stocks
    attr_accessor :image_url 
    mount_uploader :image_url, ImageUploader
    
    validates :name, :category_id,:company,:released_on,:code,:list_price,:sale_price,:description,:image_url,:delivery_days,:active,:color, presence: true
    validates :name, :cade, uniqueness: true
    validates :list_price ,:sale_price, numericality: {greater_than_or_equal_to: 0}
    #image_urlの検証はimage_uploader.rbに記述されている
    
  #カート内の商品(参照されている商品が削除されないようにする)    
  def ensure_not_referenced_by_any_cart_item
    if cart_items.empty?
      return true
    else
      errors.add(:base, '品目が存在します')
      return false
    end
  end
  
end
