class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  before_save {self.email = self.email.downcase}
  validates :name_kana, presence: true, length: {maximum: 40}, format: { with: /\A[\p{katakana}\p{blank}ー－]+\z/, message: 'はカタカナで入力して下さい。'}
  validates :name_kanji, presence: true, length: {maximum: 30}
  validates :email, presence: true, length: {maximum: 100}
  
  validates :password, presence: true, length:{minimum: 6}, :on => :create
  validates :password, length: {minimum: 6, maximum: 120}, on: :update, allow_blank: true
  
  has_many :mylists, dependent: :destroy
  has_many :products,through: :mylists
  
  has_many :reviews, dependent: :destroy
  has_many :products, through: :reviews
  
  has_many :orders, dependent: :destroy
  has_many :contacts
  
  has_one :cart, dependent: :destroy

  
end
