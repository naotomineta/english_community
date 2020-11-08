class Toeic < ActiveHash::Base
  self.data = [
    { id: 0, name: '___' },
    { id: 400, name: 400 },
    { id: 500, name: 500 },
    { id: 600, name: 600 },
    { id: 700, name: 700 },
    { id: 800, name: 800 },
    { id: 900, name: 900 }
  ]

  include ActiveHash::Associations
  has_many :rooms
end
