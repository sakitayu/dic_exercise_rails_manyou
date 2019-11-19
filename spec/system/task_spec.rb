require 'rails_helper'

RSpec.describe "タスク管理機能", type: :system do
  before do
    task1 = FactoryBot.create(:task, name: 'タスク名テスト1', detail: 'タスク名詳細1')
    task2 = FactoryBot.create(:task, name: 'タスク名テスト2', detail: 'タスク名詳細2')
    task3 = FactoryBot.create(:task, name: 'タスク名テスト3', detail: 'タスク名詳細3')
  end

  describe 'タスク一覧のテスト' do
    context 'タスクを作成した場合' do
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
        all('tbody td')[3].click_on '詳細画面'
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
        all('tbody td')[3].click_on '詳細画面'
        expect(page).to have_content 'タスク名テスト3'
        expect(page).to have_content 'タスク名詳細3'

        visit tasks_path
        all('tbody td')[9].click_on '詳細画面'
        expect(page).to have_content 'タスク名テスト2'
        expect(page).to have_content 'タスク名詳細2'

        visit tasks_path
        all('tbody td')[15].click_on '詳細画面'
        expect(page).to have_content 'タスク名テスト1'
        expect(page).to have_content 'タスク名詳細1'
      end
    end
  end

  describe "タスク作成のテスト2(終了期限を入力した場合)" do
    context '必要項目を入力して、createボタンを押した場合' do
      it 'データが保存されること' do
        visit new_task_path
        fill_in 'タスク名', with: 'タスク名テスト'
        fill_in 'タスク詳細', with: 'タスク名詳細'
        select '2019', from: 'task_expired_at_1i'
        select '11月', from: 'task_expired_at_2i'
        select '20', from: 'task_expired_at_3i'
        select '11', from: 'task_expired_at_4i'
        select '15', from: 'task_expired_at_5i'
        task = FactoryBot.create(:task, name: 'タスク名テスト', detail: 'タスク名詳細', expired_at: '2019-11-20 11:15:00')
        click_on '登録する'
        expect(page).to have_content 'タスク名テスト'
        expect(page).to have_content 'タスク名詳細'
        expect(page).to have_content '2019-11-20 11:15:00 +0900'
      end
    end
  end
end