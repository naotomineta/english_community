require 'rails_helper'

RSpec.describe Message, type: :model do
  describe '#create' do
    before do
      @message = FactoryBot.build(:message)
    end

    it 'contentがあれば保存できる' do
      expect(@message).to be_valid
    end

    it 'contentが空では登録できないこと' do
      @message.content = nil
      @message.valid?
      expect(@message.errors.full_messages).to include("Content can't be blank")
    end
  end
end
