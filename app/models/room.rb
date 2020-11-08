class Room < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  belongs_to :user
  belongs_to :toeic

  validates :name, presence: true
  validates :toeic_id, numericality: { other_than: 0 }
end
