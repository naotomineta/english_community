require 'rails_helper'

RSpec.describe 'Rooms', type: :system do
  before do
    @user = FactoryBot.create(:user)
  end

  context 'ルームの新規作成ができるとき' do
    it '正しい情報を入力すればルームの新規作成ができてトップページに移動する' do
      # トップページに移動する
      visit root_path
      # トップページにルーム作成ページへ遷移するボタンがあることを確認する
      expect(page).to have_button('create room!')
      # ログインする
      sign_in(@user)
      # ルーム作成ページへ移動する
      visit new_room_path
      # ルーム名を入力する
      fill_in 'room_name', with: 'english'
      # Toeic level枠をクリックするとセレクトボックスが出てくるのを確認する
      find('#toeic').click
      expect(page).to have_content(400)
      expect(page).to have_content(500)
      expect(page).to have_content(600)
      expect(page).to have_content(700)
      expect(page).to have_content(800)
      expect(page).to have_content(900)
      # Toeic levelを選択する
      select '400'
      # createボタンを押すとルームモデルのカウントが1上がることを確認する
      expect do
        find('#create-room').click
      end.to change { Room.count }.by(1)
      # トップページへ遷移する
      expect(current_path).to eq root_path
      # 部屋があることを確認する
      expect(page).to have_css('.rooms')
    end
  end
  context 'ルームの新規作成ができないとき' do
    it '誤った情報ではルームの新規作成ができずに新規作成ページへ戻ってくる' do
      # トップページに移動する
      visit root_path
      # ログインする
      sign_in(@user)
      # 新規登録ページへ移動する
      visit new_room_path
      # ルーム情報を入力する
      fill_in 'room_name', with: ''
      # サインアップボタンを押してもユーザーモデルのカウントは上がらないことを確認する
      expect  do
        find('#create-room').click
      end.to change { Room.count }.by(0)
      # 新規登録ページへ戻されることを確認する
      expect(current_path).to eq '/rooms'
      # エラーメッセージが表示されていることを確認する
      expect(page).to have_content("Name can't be blank")
      expect(page).to have_content('Toeic must be other than 0')
    end
  end
  context 'ルームの削除' do
    it 'チャットルームを削除すると、関連するメッセージがすべて削除されていること' do
      # 予めルームをDBに保存する
      @room = FactoryBot.create(:room)
      # サインインする
      sign_in(@room.user)
      # 作成されたチャットルームへ遷移する
      visit room_path(@room)
      # メッセージ情報を5つDBに追加する
      FactoryBot.create_list(:message, 5, room_id: @room.id, user_id: @room.user.id)
      # delet the roomボタンをクリックすることで、作成した5つのメッセージが削除されていることを確認する
      expect do
        find_button('delete the room').click
      end.to change { @room.messages.count }.by(-5)
      # トップページに遷移していることを確認する
      expect(current_path).to eq root_path
    end
  end
  context 'メモの表示' do
    it 'メモが保存されていればdisplayボタンを押すと表示される' do
      # 予めルームとメモをDBに保存する
      @room = FactoryBot.create(:room)
      @memo = FactoryBot.create(:memo)
      # トップページに移動する
      visit root_path
      # サインインする
      sign_in(@room.user)
      # メモ一覧ページへ移動する
      find('#memo').click
      # メモ作成ページへ移動する
      find('.add-a-memo').click
      # メモ名を入力する
      fill_in 'memo_content', with: 'english'
      fill_in 'memo_translation', with: '英語'
      # Add a memoボタンを押すとルームモデルのカウントが1上がることを確認する
      expect  do
        find('#addmemo').click
      end.to change { Memo.count }.by(1)
      # トップページに遷移する
      visit root_path
      # 作成されたチャットルームへ遷移する
      visit room_path(@room)
      # displayをクリックするとメモが表示されることを確認する
      find('#display').click
      expect(page).to have_content('english')
      expect(page).to have_content('英語')
    end
  end
end
