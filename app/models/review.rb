class Review < ApplicationRecord
  belongs_to :product
  belongs_to :user
  has_many :likes, dependent: :destroy
  #has_many :users, through: :likes
    
  validate :add_error_sample
  validates :name, :title, :description, :user_id, :product_id, presence: true
  validates :title, length: {maximum: 50}
  validates :description, length: {maximum: 300}
  default_scope -> {order('created_at DESC')}
    
  def add_error_sample
    if rank == 0
      errors[:base] << "1〜5段階で評価して下さい"
    end
  end
end
