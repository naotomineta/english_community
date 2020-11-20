class Memo < ApplicationRecord
  validates :content, presence: true
  validates :translation, presence: true

  belongs_to :user
end
