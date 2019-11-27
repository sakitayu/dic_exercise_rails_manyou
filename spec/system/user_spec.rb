require 'rails_helper'

RSpec.describe "ユーザー管理機能", type: :system do
  before do
    user1 = FactoryBot.create(:user, name: "ユーザー1", email: "user1@example.com", password: "password1")
    user2 = FactoryBot.create(:user, name: "ユーザー2", email: "user2@example.com", password: "password2")
    user3 = FactoryBot.create(:user, name: "ユーザー3", email: "user3@example.com", password: "password3")
    user4 = FactoryBot.create(:user, name: "ユーザー4", email: "user4@example.com", password: "password4")

    task1 = FactoryBot.create(:task, name: 'タスク名テスト1', detail: 'タスク名詳細1', expired_at: '2019-11-22 12:27:00', status: '未着手', user: user1)
    task2 = FactoryBot.create(:task, name: 'タスク名テスト2', detail: 'タスク名詳細2', expired_at: '2019-11-23 12:27:00', status: '着手中', user: user1 )
    task3 = FactoryBot.create(:task, name: 'タスク名テスト3', detail: 'タスク名詳細3', expired_at: '2019-11-24 12:27:00', status: '完了', user: user1 )
    task4 = FactoryBot.create(:task, name: 'タスク名テスト4', detail: 'タスク名詳細4', expired_at: '2019-11-21 12:27:00', status: '完了', user: user1 )
  end

  describe 'ユーザー一覧のテスト' do
    context 'ユーザーを作成した場合' do
      it '作成済みのユーザーが表示されること' do
        visit admin_users_path
        expect(page).to have_content 'ユーザー1'
        expect(page).to have_content 'ユーザー2'
        expect(page).to have_content 'ユーザー3'
        expect(page).to have_content 'ユーザー4'
      end
    end
  end

  describe "タスク作成のテスト" do
    before do
      user = FactoryBot.create(:user, name: "ユーザー", email: "user@example.com", password: "password")
    end

    context '必要項目を入力して、「登録する」ボタンを押した場合' do
      it 'データが保存されること' do
        visit new_admin_user_path
        fill_in "名前", with: "ユーザー"
        fill_in "メールアドレス", with: "user@example.com"
        fill_in "パスワード", with: "password"
        fill_in "確認用パスワード", with: "password"
        click_button "アカウントを作成"
        expect(page).to have_content 'ユーザー'
      end
    end
  end

  describe "ユーザー詳細のテスト" do
    context '任意のユーザー詳細に遷移した場合' do
      it '該当ユーザーの内容が表示されたページに遷移すること' do
        visit admin_users_path
        all('div')[1].click_on '詳細'
        expect(page).to have_content 'ユーザー2'
        expect(page).to have_content 'user2@example.com'
        expect(page).to have_content 'タスク一覧'
      end
    end
  end

  describe "ユーザー編集で名前を変更できるかのテスト" do
    context '名前を変更して、「更新する」ボタンを押した場合' do
      it '名前が更新されているいること' do
        visit admin_users_path
        all('div')[1].click_on '編集'
        fill_in "名前", with: "変更したユーザー"
        fill_in "メールアドレス", with: "user@example.com"
        fill_in "パスワード", with: "password"
        fill_in "確認用パスワード", with: "password"
        click_button "更新する"
        expect(page).to have_content '変更したユーザー'
      end
    end
  end

  describe "ユーザー削除のテスト" do
    context 'ユーザーを削除した場合' do
      it 'ユーザー一覧画面から削除したユーザーが消えていること' do
        visit admin_users_path
        all('div')[1].click_on '削除'
        page.driver.browser.switch_to.alert.accept
        expect(page).not_to have_content 'ユーザー2'
      end
    end
  end
end