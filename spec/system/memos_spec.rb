require 'rails_helper'

RSpec.describe 'Memos', type: :system do
  before do
    @user = FactoryBot.create(:user)
  end

  context 'メモの新規作成ができるとき' do
    it '正しい情報を入力すればメモの新規作成ができてメモ一覧に移動する' do
      # トップページに移動する
      visit root_path
      # ログインする
      sign_in(@user)
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
      # メモ一覧へ遷移する
      expect(current_path).to eq memos_path
      # 作成したメモが表示されていることを確認する
      expect(page).to have_content('english')
      expect(page).to have_content('英語')
    end
  end
  context 'メモの新規作成ができないとき' do
    it '誤った情報ではメモの新規作成ができずに新規作成ページへ戻ってくる' do
      # トップページに移動する
      visit root_path
      # ログインする
      sign_in(@user)
      # メモ一覧ページへ移動する
      find('#memo').click
      # メモ作成ページへ移動する
      find('.add-a-memo').click
      # メモ情報を入力する
      fill_in 'memo_content', with: ''
      fill_in 'memo_translation', with: ''
      # Add a memoボタンを押してもメモモデルのカウントは上がらないことを確認する
      expect  do
        find('#addmemo').click
      end.to change { Memo.count }.by(0)
      # 新規作成ページへ戻されることを確認する
      expect(current_path).to eq '/memos'
      # エラーメッセージが表示されていることを確認する
      expect(page).to have_content("Content can't be blank")
      expect(page).to have_content("Translation can't be blank")
    end
  end
end
