class Product < ApplicationRecord
    belongs_to :category
    has_many :mylists
    has_many :users, through: :mylists
    
    has_many :reviews
    has_many :users, through: :reviews
    
    has_many :cart_items, dependent: :destroy
    has_many :orders, through: :cart_items
    has_one :stock
    
    attr_accessor :image_url 
    mount_uploader :image_url, ImageUploader
    validates :name, :category_id,:company,:released_on,:code,:list_price,:sale_price,:description,:image_url,:delivery_days,:active,:color, presence: true
    validates :name, :code, uniqueness: true
    validates :list_price ,:sale_price, numericality: {greater_than_or_equal_to: 0}
    #image_urlの検証はimage_uploader.rbに記述されている
    
    
    
  def self.search(search)
    if search
      where(['name LIKE ?', "%#{search}%"]) 
    else
      all 
    end
  end
  
  #最大配達日数を入れるためのグローバル変数。改善の余地あり。
  $max_day = 0
  
  def delivery_day(item)
    $max_day = item.product.delivery_days if item.product.delivery_days > $max_day 
  end
  
  
  def sold!
    self.stock.update(sales_quantity: self.stock.sales_quantity - 1)
  end
  
  
end
