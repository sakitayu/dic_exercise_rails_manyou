require 'rails_helper'

RSpec.describe "タスク管理機能", type: :system do
  before do
    task1 = FactoryBot.create(:task, name: 'タスク名テスト1', detail: 'タスク名詳細1', expired_at: '2019-11-22 12:27:00', status: '未着手')
    task2 = FactoryBot.create(:task, name: 'タスク名テスト2', detail: 'タスク名詳細2', expired_at: '2019-11-23 12:27:00', status: '着手中')
    task3 = FactoryBot.create(:task, name: 'タスク名テスト3', detail: 'タスク名詳細3', expired_at: '2019-11-24 12:27:00', status: '完了')
    task4 = FactoryBot.create(:task, name: '4個目のテスト', detail: 'タスク名詳細4', expired_at: '2019-11-21 12:27:00', status: '完了')
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
    context '必要項目を入力して、「登録する」ボタンを押した場合' do
      it 'データが保存されること' do
        visit new_task_path
        fill_in 'タスク名', with: 'タスク名テスト'
        fill_in 'タスク詳細', with: 'タスク名詳細'
        select '2019', from: 'task_expired_at_1i'
        select '11', from: 'task_expired_at_2i'
        select '20', from: 'task_expired_at_3i'
        select '11', from: 'task_expired_at_4i'
        select '15', from: 'task_expired_at_5i'
        task = FactoryBot.create(:task, name: 'タスク名テスト', detail: 'タスク名詳細', expired_at: '2019-11-20 11:15:00')
        click_on '登録する'
        expect(page).to have_content 'タスク名テスト'
        expect(page).to have_content 'タスク名詳細'
        expect(page).to have_content '2019-11-20 11:15:00'
      end
    end
  end

  describe "タスク詳細のテスト" do
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示されたページに遷移すること' do
        visit tasks_path
        all('tbody td')[4].click_on '詳細画面'
        expect(page).to have_content 'タスク詳細画面'
        expect(page).to have_content '4個目のテスト'
        expect(page).to have_content 'タスク名詳細4'
      end
    end
  end

  describe "タスクが作成日時の降順に並んでいるかのテスト" do
    context 'index画面に遷移した場合' do
      it '該当タスクの内容が作成日時の降順に並んでいること' do
        visit tasks_path
        all('tbody td')[4].click_on '詳細画面'
        expect(page).to have_content '4個目のテスト'
        expect(page).to have_content 'タスク名詳細4'

        visit tasks_path
        all('tbody td')[11].click_on '詳細画面'
        expect(page).to have_content 'タスク名テスト3'
        expect(page).to have_content 'タスク名詳細3'

        visit tasks_path
        all('tbody td')[18].click_on '詳細画面'
        expect(page).to have_content 'タスク名テスト2'
        expect(page).to have_content 'タスク名詳細2'

        visit tasks_path
        all('tbody td')[25].click_on '詳細画面'
        expect(page).to have_content 'タスク名テスト1'
        expect(page).to have_content 'タスク名詳細1'
      end
    end
  end

  describe "タスクが終了期限の降順に並んでいるかのテスト" do
    context '終了期限をクリックした場合' do
      it '該当タスクの内容が作成日時の降順に並んでいること' do
        visit tasks_path
        all('tbody th')[2].click_on '終了期限'
        sleep 1
        expect(all('tbody td')[0]).to have_content 'タスク名テスト3'
        expect(all('tbody td')[7]).to have_content 'タスク名テスト2'
        expect(all('tbody td')[14]).to have_content 'タスク名テスト1'
        expect(all('tbody td')[21]).to have_content '4個目のテスト'
      end
    end
  end

  describe "タスク編集画面でステータスを変更できるかのテスト" do
    context 'ステータスを選択して、「更新する」ボタンを押した場合' do
      it 'ステータスが更新されているいること' do
        visit tasks_path
        all('tbody td')[5].click_on '編集画面'
        select '完了', from: 'task_status'
        #task = FactoryBot.create(:task, name: 'タスク名テスト', detail: 'タスク名詳細', expired_at: '2019-11-20 11:15:00')
        click_on '更新する'
        expect(page).to have_content '完了'
        visit tasks_path
        expect(all('tbody td')[3]).to have_content '完了'
      end
    end
  end

  describe "インデックス画面の検索ボタンで検索結果が反映されているかのテスト" do
    context 'タイトルを記入して、「検索」ボタンを押した場合' do
      it '検索結果が正しく表示されているいること' do
        visit tasks_path
        fill_in 'タイトル', with: 'タスク'
        click_on '検索'
        expect(all('tbody td')[0]).to have_content 'タスク名テスト1'
        expect(all('tbody td')[7]).to have_content 'タスク名テスト2'
        expect(all('tbody td')[14]).to have_content 'タスク名テスト3'
      end
    end
  end

  describe "インデックス画面の検索ボタンで検索結果が反映されているかのテスト" do
    context 'ステータスを完了にして、「検索」ボタンを押した場合' do
      it '検索結果が正しく表示されているいること' do
        visit tasks_path
        select '完了', from: 'status'
        click_on '検索'
        expect(all('tbody td')[0]).to have_content 'タスク名テスト3'
        expect(all('tbody td')[7]).to have_content '4個目のテスト'
      end
    end
  end

  describe "インデックス画面の検索ボタンで検索結果が反映されているかのテスト" do
    context 'ステータスを完了にして、「検索」ボタンを押した場合' do
      it '検索結果が正しく表示されているいること' do
        visit tasks_path
        select '完了', from: 'status'
        fill_in 'タイトル', with: 'タスク'
        click_on '検索'
        expect(all('tbody td')[0]).to have_content 'タスク名テスト3'
      end
    end
  end
end