class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :name_kana,:name_kanji,:email,presence: true
  
  has_many :mylists, dependent: :destroy
  has_many :order_histories, dependent: :destroy
  has_many :products, through: :order_histories
  
  has_many :payments, dependent: :destroy
end
