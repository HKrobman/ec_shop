class Contact < ApplicationRecord
  belongs_to :user
  validates :name, :telphone, :email, :content_type, :content, :user_id, presence: true
end
