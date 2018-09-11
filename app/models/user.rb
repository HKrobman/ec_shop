class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  before_save {self.email = self.email.downcase}
  validates :name_kana, presence: true, length: {maximum: 40}
  validates :name_kanji, presence: true, length: {maximum: 30}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: 100}, format: {with: VALID_EMAIL_REGEX}
  validates :password, presence: true, length:{minimum: 6}
  
  has_many :mylists, dependent: :destroy
  has_many :products,through: :mylists
  
  has_many :order_histories, dependent: :destroy
  has_many :products, through: :order_histories
  
  has_one :cart, dependent: :destroy
  
  has_many :payment_methods, dependent: :destroy
end
