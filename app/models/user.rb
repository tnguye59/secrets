class User < ActiveRecord::Base
  has_secure_password
  has_many :secrets
  has_many :likes, dependent: :destroy
  has_many :secrets_liked, through: :likes, source: :secret
	validates :name, :email, presence: true
	validates :password, :password_confirmation, presence: true, on: :create
end
