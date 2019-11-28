require 'rails_helper'

RSpec.describe User, type: :model do

  it "nameが空ならバリデーションが通らない" do
    task = User.new(name: '', detail: '失敗テスト')
    expect(task).not_to be_valid
  end

  it "detailが空ならバリデーションが通らない" do
    task = User.new(name: '失敗テスト', detail: '')
    expect(task).not_to be_valid
  end

  it "nameとdetailに内容が記載されていればバリデーションが通る" do
    task = User.new(name: '成功テスト', detail: '成功テスト')
    expect(task).to be_valid
  end

  it "検索文字列に一致したタスクが一覧に表示される" do
    task1 = User.create(name: 'タスク1', detail: 'タスク1の中身', expired_at: '2019-11-22 12:27:00', status: '完了')
    task2 = User.create(name: 'タスク2', detail: 'タスク2のなかみ', expired_at: '2019-11-23 12:27:00', status: '未着手')
    task3 = User.create(name: 'タスク3', detail: 'タスク3のナカミ', expired_at: '2019-11-24 12:27:00', status: '着手中')
    expect(User.name_search("タスク")).to include(task1, task2, task3)
    expect(User.status_search("未着手")).to include(task2)
    expect(User.name_and_status_search("タスク", "着手中")).to include(task3)
    expect(User.name_search("ﾆｬﾎﾆｬﾎﾀﾏｸﾛｰ")).to be_empty
  end
end
