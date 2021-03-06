require 'rails_helper'

RSpec.describe "タスク管理機能", type: :system do

  describe 'タスク一覧のテスト' do
    before do
      user = FactoryBot.create(:user, name: "ユーザー2", email: "user2@example.com", password: "password")
      task1 = FactoryBot.create(:task, name: 'タスク名テスト1', detail: 'タスク名詳細1', expired_at: '2019-11-22 12:27:00', status: '未着手', user: user)
      task2 = FactoryBot.create(:task, name: 'タスク名テスト2', detail: 'タスク名詳細2', expired_at: '2019-11-23 12:27:00', status: '着手中', user: user )
      task3 = FactoryBot.create(:task, name: 'タスク名テスト3', detail: 'タスク名詳細3', expired_at: '2019-11-24 12:27:00', status: '完了', user: user )
      task4 = FactoryBot.create(:task, name: '4個目のテスト', detail: 'タスク名詳細4', expired_at: '2019-11-21 12:27:00', status: '完了', user: user )
  
      visit new_session_path
      fill_in "Eメール", with: "user2@example.com"
      fill_in "パスワード", with: "password"
      click_button "ログイン"
    end

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
    before do
      user = FactoryBot.create(:user, name: "ユーザー2", email: "user2@example.com", password: "password")
      task = FactoryBot.create(:task, name: 'タスク名テスト保存', detail: 'タスク名詳細保存', expired_at: '2019-11-20', status: '未着手', user: user )
  
      visit new_session_path
      fill_in "Eメール", with: "user2@example.com"
      fill_in "パスワード", with: "password"
      click_button "ログイン"
    end

    context '必要項目を入力して、「登録する」ボタンを押した場合' do
      
      it 'データが保存されること' do
        visit new_task_path
        fill_in 'タスク名', with: 'タスク名テスト保存'
        fill_in 'タスク詳細', with: 'タスク名詳細保存'
        select '2019', from: 'task_expired_at_1i'
        select '11', from: 'task_expired_at_2i'
        select '20', from: 'task_expired_at_3i'
        #user = FactoryBot.create(:user, name: "ユーザー", email: "user@example.com", password: "password")
        
        click_on '登録する'
        expect(page).to have_content 'タスク名テスト保存'
        expect(page).to have_content 'タスク名詳細保存'
        expect(page).to have_content '2019/11/20'
      end
    end
  end

  describe "タスク詳細のテスト" do
    before do
      user = FactoryBot.create(:user, name: "ユーザー2", email: "user2@example.com", password: "password")
      task1 = FactoryBot.create(:task, name: 'タスク名テスト1', detail: 'タスク名詳細1', expired_at: '2019-11-22 12:27:00', status: '未着手', user: user)
      task2 = FactoryBot.create(:task, name: 'タスク名テスト2', detail: 'タスク名詳細2', expired_at: '2019-11-23 12:27:00', status: '着手中', user: user )
      task3 = FactoryBot.create(:task, name: 'タスク名テスト3', detail: 'タスク名詳細3', expired_at: '2019-11-24 12:27:00', status: '完了', user: user )
      task4 = FactoryBot.create(:task, name: '4個目のテスト', detail: 'タスク名詳細4', expired_at: '2019-11-21 12:27:00', status: '完了', user: user )
  
      visit new_session_path
      fill_in "Eメール", with: "user2@example.com"
      fill_in "パスワード", with: "password"
      click_button "ログイン"
    end

    context '任意のタスク詳細に遷移した場合' do
      it '該当タスクの内容が表示されたページに遷移すること' do
        visit tasks_path
        all('tbody td')[5].click_on '詳細'
        expect(page).to have_content 'タスク詳細'
        expect(page).to have_content '4個目のテスト'
        expect(page).to have_content 'タスク名詳細4'
      end
    end
  end

  describe "タスクが作成日時の降順に並んでいるかのテスト" do
    before do
      user = FactoryBot.create(:user, name: "ユーザー2", email: "user2@example.com", password: "password")
      task1 = FactoryBot.create(:task, name: 'タスク名テスト1', detail: 'タスク名詳細1', expired_at: '2019-11-22 12:27:00', status: '未着手', user: user)
      task2 = FactoryBot.create(:task, name: 'タスク名テスト2', detail: 'タスク名詳細2', expired_at: '2019-11-23 12:27:00', status: '着手中', user: user )
      task3 = FactoryBot.create(:task, name: 'タスク名テスト3', detail: 'タスク名詳細3', expired_at: '2019-11-24 12:27:00', status: '完了', user: user )
      task4 = FactoryBot.create(:task, name: '4個目のテスト', detail: 'タスク名詳細4', expired_at: '2019-11-21 12:27:00', status: '完了', user: user )
  
      visit new_session_path
      fill_in "Eメール", with: "user2@example.com"
      fill_in "パスワード", with: "password"
      click_button "ログイン"
    end

    context 'indexに遷移した場合' do
      it '該当タスクの内容が作成日時の降順に並んでいること' do
        visit tasks_path
        all('tbody td')[5].click_on '詳細'
        expect(page).to have_content '4個目のテスト'
        expect(page).to have_content 'タスク名詳細4'

        visit tasks_path
        all('tbody td')[13].click_on '詳細'
        expect(page).to have_content 'タスク名テスト3'
        expect(page).to have_content 'タスク名詳細3'

        visit tasks_path
        all('tbody td')[21].click_on '詳細'
        expect(page).to have_content 'タスク名テスト2'
        expect(page).to have_content 'タスク名詳細2'

        visit tasks_path
        all('tbody td')[29].click_on '詳細'
        expect(page).to have_content 'タスク名テスト1'
        expect(page).to have_content 'タスク名詳細1'
      end
    end
  end

  describe "タスクが終了期限の降順に並んでいるかのテスト" do
    before do
      user = FactoryBot.create(:user, name: "ユーザー2", email: "user2@example.com", password: "password")
      task1 = FactoryBot.create(:task, name: 'タスク名テスト1', detail: 'タスク名詳細1', expired_at: '2019-11-22 12:27:00', status: '未着手', user: user)
      task2 = FactoryBot.create(:task, name: 'タスク名テスト2', detail: 'タスク名詳細2', expired_at: '2019-11-23 12:27:00', status: '着手中', user: user )
      task3 = FactoryBot.create(:task, name: 'タスク名テスト3', detail: 'タスク名詳細3', expired_at: '2019-11-24 12:27:00', status: '完了', user: user )
      task4 = FactoryBot.create(:task, name: '4個目のテスト', detail: 'タスク名詳細4', expired_at: '2019-11-21 12:27:00', status: '完了', user: user )
  
      visit new_session_path
      fill_in "Eメール", with: "user2@example.com"
      fill_in "パスワード", with: "password"
      click_button "ログイン"
    end

    context '終了期限をクリックした場合' do
      it '該当タスクの内容が作成日時の降順に並んでいること' do
        visit tasks_path
        all('tbody th')[2].click_on '終了期限'
        sleep 1
        expect(all('tbody td')[0]).to have_content 'タスク名テスト3'
        expect(all('tbody td')[8]).to have_content 'タスク名テスト2'
        expect(all('tbody td')[16]).to have_content 'タスク名テスト1'
        expect(all('tbody td')[24]).to have_content '4個目のテスト'
      end
    end
  end

  describe "タスク編集でステータスを変更できるかのテスト" do
    before do
      user = FactoryBot.create(:user, name: "ユーザー2", email: "user2@example.com", password: "password")
      task1 = FactoryBot.create(:task, name: 'タスク名テスト1', detail: 'タスク名詳細1', expired_at: '2019-11-22 12:27:00', status: '未着手', user: user)
      task2 = FactoryBot.create(:task, name: 'タスク名テスト2', detail: 'タスク名詳細2', expired_at: '2019-11-23 12:27:00', status: '着手中', user: user )
      task3 = FactoryBot.create(:task, name: 'タスク名テスト3', detail: 'タスク名詳細3', expired_at: '2019-11-24 12:27:00', status: '完了', user: user )
      task4 = FactoryBot.create(:task, name: '4個目のテスト', detail: 'タスク名詳細4', expired_at: '2019-11-21 12:27:00', status: '完了', user: user )
  
      visit new_session_path
      fill_in "Eメール", with: "user2@example.com"
      fill_in "パスワード", with: "password"
      click_button "ログイン"
    end

    context 'ステータスを選択して、「更新する」ボタンを押した場合' do
      it 'ステータスが更新されているいること' do
        visit tasks_path
        all('tbody td')[6].click_on '編集'
        select '完了', from: 'task_status'
        click_on '更新する'
        expect(page).to have_content '完了'
        visit tasks_path
        expect(all('tbody td')[3]).to have_content '完了'
      end
    end
  end

  describe "インデックスの検索ボタンで検索結果が反映されているかのテスト1" do
    before do
      user = FactoryBot.create(:user, name: "ユーザー2", email: "user2@example.com", password: "password")
      task1 = FactoryBot.create(:task, name: 'タスク名テスト1', detail: 'タスク名詳細1', expired_at: '2019-11-22 12:27:00', status: '未着手', user: user)
      task2 = FactoryBot.create(:task, name: 'タスク名テスト2', detail: 'タスク名詳細2', expired_at: '2019-11-23 12:27:00', status: '着手中', user: user )
      task3 = FactoryBot.create(:task, name: 'タスク名テスト3', detail: 'タスク名詳細3', expired_at: '2019-11-24 12:27:00', status: '完了', user: user )
      task4 = FactoryBot.create(:task, name: '4個目のテスト', detail: 'タスク名詳細4', expired_at: '2019-11-21 12:27:00', status: '完了', user: user )
  
      visit new_session_path
      fill_in "Eメール", with: "user2@example.com"
      fill_in "パスワード", with: "password"
      click_button "ログイン"
    end

    context 'タイトルを記入して、「検索」ボタンを押した場合' do
      it '検索結果が正しく表示されているいること' do
        visit tasks_path
        fill_in 'タイトル', with: 'タスク'
        click_on '検索'
        expect(all('tbody td')[0]).to have_content 'タスク名テスト1'
        expect(all('tbody td')[8]).to have_content 'タスク名テスト2'
        expect(all('tbody td')[16]).to have_content 'タスク名テスト3'
      end
    end
  end

  describe "インデックスの検索ボタンで検索結果が反映されているかのテスト2" do
    before do
      user = FactoryBot.create(:user, name: "ユーザー2", email: "user2@example.com", password: "password")
      task1 = FactoryBot.create(:task, name: 'タスク名テスト1', detail: 'タスク名詳細1', expired_at: '2019-11-22 12:27:00', status: '未着手', user: user)
      task2 = FactoryBot.create(:task, name: 'タスク名テスト2', detail: 'タスク名詳細2', expired_at: '2019-11-23 12:27:00', status: '着手中', user: user )
      task3 = FactoryBot.create(:task, name: 'タスク名テスト3', detail: 'タスク名詳細3', expired_at: '2019-11-24 12:27:00', status: '完了', user: user )
      task4 = FactoryBot.create(:task, name: '4個目のテスト', detail: 'タスク名詳細4', expired_at: '2019-11-21 12:27:00', status: '完了', user: user )
  
      visit new_session_path
      fill_in "Eメール", with: "user2@example.com"
      fill_in "パスワード", with: "password"
      click_button "ログイン"
    end

    context 'ステータスを完了にして、「検索」ボタンを押した場合' do
      it '検索結果が正しく表示されているいること' do
        visit tasks_path
        select '完了', from: 'status'
        click_on '検索'
        expect(all('tbody td')[0]).to have_content 'タスク名テスト3'
        expect(all('tbody td')[8]).to have_content '4個目のテスト'
      end
    end
  end

  describe "インデックスの検索ボタンで検索結果が反映されているかのテスト3" do
    before do
      user = FactoryBot.create(:user, name: "ユーザー2", email: "user2@example.com", password: "password")
      task1 = FactoryBot.create(:task, name: 'タスク名テスト1', detail: 'タスク名詳細1', expired_at: '2019-11-22 12:27:00', status: '未着手', user: user)
      task2 = FactoryBot.create(:task, name: 'タスク名テスト2', detail: 'タスク名詳細2', expired_at: '2019-11-23 12:27:00', status: '着手中', user: user )
      task3 = FactoryBot.create(:task, name: 'タスク名テスト3', detail: 'タスク名詳細3', expired_at: '2019-11-24 12:27:00', status: '完了', user: user )
      task4 = FactoryBot.create(:task, name: '4個目のテスト', detail: 'タスク名詳細4', expired_at: '2019-11-21 12:27:00', status: '完了', user: user )
  
      visit new_session_path
      fill_in "Eメール", with: "user2@example.com"
      fill_in "パスワード", with: "password"
      click_button "ログイン"
    end

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