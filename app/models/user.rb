class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true

  has_many :messages
  has_many :memos

  mount_uploader :image, ImageUploader
end
