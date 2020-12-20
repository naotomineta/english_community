require 'rails_helper'

RSpec.describe Room, type: :model do
  describe '#create' do
    before do
      @room = FactoryBot.build(:room)
    end

    it 'titleとcontentとtoeic_idが存在すれば登録できる' do
      expect(@room).to be_valid
    end

    it 'titleが空では登録できないこと' do
      @room.title = nil
      @room.valid?
      expect(@room.errors.full_messages).to include("Title can't be blank")
    end

    it 'contentが空では登録できないこと' do
      @room.content = nil
      @room.valid?
      expect(@room.errors.full_messages).to include("Content can't be blank")
    end

    it 'toeic_idが空だと登録できない' do  
      @room.toeic_id = ''
      @room.valid?
      expect(@room.errors.full_messages).to include('Toeic is not a number')
    end
  end
end
