require 'rails_helper'

RSpec.describe 'メッセージ投稿機能', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @room = FactoryBot.create(:room)
  end

  context '投稿に成功したとき', js: true do
    it 'メッセージの投稿に成功すると、投稿した内容が表示されている' do
      # トップページに移動する
      visit root_path
      # サインインする
      sign_in(@room.user)
      # 作成されたチャットルームへ遷移する
      click_on('enter')
      visit room_path(@room)
      # 値をテキストフォームに入力する
      fill_in 'messagecontent', with: 'hello'
      # フォーム内でエンターキーを押すとメッセージが表示される
      find('.form-message').native.send_key(:enter)
      expect(page).to have_css('.message-whole')
    end
  end
  context '投稿に失敗した時', js: true do
    it '送る値が空のため、メッセージの送信に失敗すること' do
      # トップページに移動する
      visit root_path
      # サインインする
      sign_in(@room.user)
      # 作成されたチャットルームへ遷移する
      visit room_path(@room)
      # フォームが空のままエンターキーを押してもメッセージが表示されないことを確認する
      find('#messageform').native.send_key(:enter)
      expect(page).to have_no_content('.message-whole')
    end
  end
end
