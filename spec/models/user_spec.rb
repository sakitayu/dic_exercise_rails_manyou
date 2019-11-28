require 'rails_helper'

RSpec.describe User, type: :model do

  it "nameが空ならバリデーションが通らない" do
    user = User.new(name: '', email: 'test@example.com', password: 'password')
    expect(user).not_to be_valid
  end

  it "nameが31文字以上ならバリデーションが通らない" do
    user = User.new(name: '12345678910-12345678910-12345678910-', email: 'test@example.com', password: 'password')
    expect(user).not_to be_valid
  end

  it "emailが空ならバリデーションが通らない" do
    user = User.new(name: 'test', email: '', password: 'password')
    expect(user).not_to be_valid
  end

  it "emailが asd@asd.com のような文字列でない場合バリデーションが通らない" do
    user = User.new(name: 'test', email: 'abcdefg', password: 'password')
    expect(user).not_to be_valid
  end

  it "emailが255文字以上ならバリデーションが通らない" do
    user = User.new(name: 'test', email: '123456789101234567891012345678910123456789101234567891012345678910123456789101234567891012345678910123456789101234567891012345678910123456789101234567891012345678910123456789101234567891012345678910123456789101234567891012345678910123456789101234567891012345678910123456789101234567891012345678910123456789101234567891012345678910', password: 'password')
    expect(user).not_to be_valid
  end

  it "emailが同じ場合バリデーションが通らない" do
    user1 = User.create(name: 'test1', email: 'test@example.com', password: 'password')
    user2 = User.new(name: 'test2', email: 'test@example.com', password: 'password')
    expect(user2).not_to be_valid
  end

  it "nameとemailとpasswordに内容が条件通り(文字数、ユニーク制約、指定文字列など)記載されていればバリデーションが通る" do
    user = User.new(name: 'test', email: 'test@example.com', password: 'password')
    expect(user).to be_valid
  end
end
