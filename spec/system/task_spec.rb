require 'rails_helper'

RSpec.describe "タスク管理機能", type: :system do
  before do
    task1 = FactoryBot.create(:task, name: 'タスク名テスト1', detail: 'タスク名詳細1')
    task2 = FactoryBot.create(:task, name: 'タスク名テスト2', detail: 'タスク名詳細2')
    task3 = FactoryBot.create(:task, name: 'タスク名テスト3', detail: 'タスク名詳細3')
  end

  describe 'タスク一覧のテスト' do
    context 'タスクを作成した場合' do
      # テストコードを it '~' do end ブロックの中に記載する
      it '作成済みのタスクが表示されること' do
        
        visit tasks_path
        
        expect(page).to have_content 'タスク名テスト1'
        expect(page).to have_content 'タスク名テスト2'
        expect(page).to have_content 'タスク名テスト3'
        expect(page).to have_content 'タスク名詳細1'
        expect(page).to have_content 'タスク名詳細2'
        expect(page).to have_content 'タスク名詳細3'
        
      end
    end
  end

  describe "タスク作成のテスト" do
    context '必要項目を入力して、createボタンを押した場合' do
      it 'データが保存されること' do
        visit new_task_path
        fill_in 'タスク名', with: 'タスク名テスト'
        fill_in 'タスク詳細', with: 'タスク名詳細'
        task = FactoryBot.create(:task, name: 'タスク名テスト', detail: 'タスク名詳細')
        click_on '登録する'
        expect(page).to have_content 'タスク名テスト'
        expect(page).to have_content 'タスク名詳細'
      end
    end
  end

  describe "タスク詳細のテスト" do
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示されたページに遷移すること' do
        visit tasks_path
        # within "#show_#{task.id}" do
        #   click_on '詳細画面' 
        # end
        all('tbody td')[2].click_on '詳細画面'
        
        expect(page).to have_content 'タスク詳細画面'
        expect(page).to have_content 'タスク名テスト3'
        expect(page).to have_content 'タスク名詳細3'
      end
    end
  end

  describe "タスクが作成日時の降順に並んでいるかのテスト" do
    context 'index画面に遷移した場合' do
      it '該当タスクの内容が作成日時の降順に並んでいること' do
        visit tasks_path
        all('tbody td')[2].click_on '詳細画面'
        expect(page).to have_content 'タスク名テスト3'
        expect(page).to have_content 'タスク名詳細3'

        visit tasks_path
        all('tbody td')[7].click_on '詳細画面'
        expect(page).to have_content 'タスク名テスト2'
        expect(page).to have_content 'タスク名詳細2'

        visit tasks_path
        all('tbody td')[12].click_on '詳細画面'
        expect(page).to have_content 'タスク名テスト1'
        expect(page).to have_content 'タスク名詳細1'
      end
    end
  end
end