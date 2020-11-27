require 'rails_helper'

RSpec.describe 'Users', type: :system do
  before do
    @user = FactoryBot.build(:user)
  end
  context 'ユーザー新規登録ができるとき' do
    it '正しい情報を入力すればユーザー新規登録ができてトップページに移動する' do
      # トップページに移動する
      visit root_path
      # トップページにサインアップページへ遷移するボタンがあることを確認する
      expect(page).to have_content('sign_up')
      # 新規登録ページへ移動する
      visit new_user_registration_path
      # ユーザー情報を入力する
      fill_in 'Name', with: @user.name
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      fill_in 'Password confirmation', with: @user.password
      # サインアップボタンを押すとユーザーモデルのカウントが1上がることを確認する
      expect  do
        find('input[name="commit"]').click
      end.to change { User.count }.by(1)
      # トップページへ遷移する
      expect(current_path).to eq root_path
      # メニューアイコンをクリックするとログアウトボタンが表示されることを確認する
      find('#menu').click
      expect(page).to have_content('logout')
      # サインアップページへ遷移するボタンや、ログインページへ遷移するボタンが表示されていないことを確認する
      expect(page).to have_no_content('sign_up')
      expect(page).to have_no_content('log_in')
    end
  end
  context 'ユーザー新規登録ができないとき' do
    it '誤った情報ではユーザー新規登録ができずに新規登録ページへ戻ってくる' do
      # トップページに移動する
      visit root_path
      # トップページにサインアップページへ遷移するボタンがあることを確認する
      expect(page).to have_content('log_in')
      # 新規登録ページへ移動する
      visit new_user_registration_path
      # ユーザー情報を入力する
      fill_in 'Name', with: ''
      fill_in 'Email', with: ''
      fill_in 'Password', with: ''
      fill_in 'Password confirmation', with: ''
      # サインアップボタンを押してもユーザーモデルのカウントは上がらないことを確認する
      expect  do
        find('input[name="commit"]').click
      end.to change { User.count }.by(0)
      # 新規登録ページへ戻されることを確認する
      expect(current_path).to eq '/users'
    end
  end
  context 'ユーザーログインができるとき' do
    it 'ログインに成功し、トップページに遷移する' do
      # 予め、ユーザーをDBに保存する
      @user = FactoryBot.create(:user)
      # トップページに遷移する
      visit root_path
      # ログインボタンを押してログインページに遷移する
      click_on('log_in')
      # すでに保存されているユーザーのemailとpasswordを入力する
      fill_in 'user_email', with: @user.email
      fill_in 'user_password', with: @user.password
      # ログインボタンをクリックする
      click_on('Log in')
      # トップページに遷移していることを確認する
      expect(current_path).to eq root_path
    end
  end
  context 'ユーザーログインができないとき' do
    it 'ログインに失敗し、再びサインインページに戻ってくる' do
      # 予め、ユーザーをDBに保存する
      @user = FactoryBot.create(:user)
      # トップページに遷移する
      visit root_path
      # ログインボタンを押してログインページに遷移する
      click_on('log_in')
      # 誤ったユーザー情報を入力する
      fill_in 'user_email', with: ''
      fill_in 'user_password', with: ''
      # ログインボタンをクリックする
      click_on('Log in')
      # サインインページに戻ってきていることを確認する
      expect(current_path).to eq new_user_session_path
    end
  end
  context 'ユーザー編集ができるとき' do
    it '正しい情報を入力すればユーザーの編集ができてトップページに移動する' do
      # 予め、ユーザーをDBに保存する
      @user = FactoryBot.create(:user)
      # トップページに遷移する
      visit root_path
      # ログインする
      sign_in(@user)
      # 編集ページに遷移する
      visit edit_user_registration_path(@user.id)
      # 編集情報を入力する
      fill_in 'user_name', with: 'suzuki'
      fill_in 'user_email', with: 'p@p'
      # Updageボタンを押す
      find('.btn').click
      # トップページに遷移されているのを確認する
      expect(current_path).to eq root_path
      # usernameが変わっているのを確認する
      expect(page).to have_content('suzuki')
    end
  end
  context 'ユーザー編集ができるとき' do
    it 'ユーザー編集に失敗し、再び編集ページに戻ってくる' do
      # 予め、ユーザーをDBに保存する
      @user = FactoryBot.create(:user)
      # トップページに遷移する
      visit root_path
      # ログインする
      sign_in(@user)
      # 編集ページに遷移する
      visit edit_user_registration_path(@user.id)
      # 編集情報を入力する
      fill_in 'user_name', with: ''
      fill_in 'user_email', with: ''
      # Updageボタンを押す
      find('.btn').click
      # 編集ができず編集ページに戻されることを確認する
      expect(current_path).to eq '/users'
      # エラーメッセージが表示されているのを確認する
      expect(page).to have_content("Email can't be blank")
      expect(page).to have_content("Name can't be blank")
    end
  end
end
