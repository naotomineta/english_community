require 'rails_helper'

RSpec.describe Memo, type: :model do
  describe '#create' do
    before do
      @memo = FactoryBot.build(:memo)
    end

    it 'contentとtranslationがあれば保存できる' do
      expect(@memo).to be_valid
    end

    it 'contentが空だと保存できない' do
      @memo.content = nil
      @memo.valid?
      expect(@memo.errors.full_messages).to include("Content can't be blank")
    end

    it 'translationが空だと保存できない' do
      @memo.translation = nil
      @memo.valid?
      expect(@memo.errors.full_messages).to include("Translation can't be blank")
    end
  end
end
