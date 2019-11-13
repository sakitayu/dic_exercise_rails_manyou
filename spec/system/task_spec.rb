require 'rails_helper'

RSpec.describe Task, type: :system do
  describe 'タスク一覧画面' do
    context 'タスクを作成した場合' do
      # テストコードを it '~' do end ブロックの中に記載する
      it '作成済みのタスクが表示されること' do
        # テストで使用するためのタスクを作成
        task = FactoryBot.create(:task, name: 'タスク名テスト', detail: 'タスク名詳細')
        
        # タスク一覧ページに遷移
        visit tasks_path 
        
        # visitした（遷移した）page（タスク一覧ページ）に「task」という文字列が
        # have_contentされているか？（含まれているか？）ということをexpectする（確認・期待する）
        expect(page).to have_content 'タスク名テスト'
        
        # expectの結果が true ならテスト成功、false なら失敗として結果が出力される
      end
    end
  end

  describe 'タスク登録画面' do
    context '必要項目を入力して、createボタンを押した場合' do
      it 'データが保存されること' do
        visit new_task_path
        fill_in 'Name', with: 'タスク名テスト'
        fill_in 'Detail', with: 'タスク名詳細'
        task = FactoryBot.create(:task, name: 'タスク名テスト', detail: 'タスク名詳細')
        click_on 'Create Task'
        expect(page).to have_content 'タスク名テスト'
        expect(page).to have_content 'タスク名詳細'
      end
    end
  end

  describe 'タスク詳細画面' do
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示されたページに遷移すること' do
        task = FactoryBot.create(:task, name: 'タスク名テスト', detail: 'タスク名詳細')
        visit tasks_path
        click_on '詳細画面'
        expect(page).to have_content 'タスク詳細画面'
        expect(page).to have_content 'タスク名テスト'
        expect(page).to have_content 'タスク名詳細'
      end
    end
  end
end