class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :name_kana, presence: true
  validates :name_kanji, presence: true
  validates :email, presence: true
  
  has_many :mylists
end
