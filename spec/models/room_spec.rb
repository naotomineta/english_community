require 'rails_helper'

RSpec.describe Room, type: :model do
  describe '#create' do
    before do
      @room = FactoryBot.build(:room)
    end

    it 'nameとtoeic_idが存在すれば登録できる' do
      expect(@room).to be_valid
    end

    it 'nameが空では登録できないこと' do
      @room.name = nil
      @room.valid?
      expect(@room.errors.full_messages).to include("Name can't be blank")
    end

    it 'toeic_idが空だと登録できない' do
      @room.toeic_id = ''
      @room.valid?
      expect(@room.errors.full_messages).to include('Toeic is not a number')
    end
  end
end
