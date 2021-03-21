require 'rails_helper'

RSpec.describe "Userモデルのテスト", type: :model do
  describe "実際に保存してみる" do
    it "有効な内容の場合保存されるか" do
      expect(FactoryBot.build(:user)).to be_valid
    end
  end
  
  context "空白のバリデーションチェック" do
    it "nameが空白の場合にバリデーションチェックされ空白のエラーメッセージが返ってきているか" do
      user = User.new(name: "", email: "hogehoge@mail.com", encrypted_password: "hogehoge")
      expect(user).to be_invalid
      expect(user.errors[:name]).to include("を入力してください")
    end
    it "passwordが空白の場合にバリデーションチェックされるか" do
      user = User.new(name: "taro", email: "hogehoge@mail.com", password: "")
      expect(user).to be_invalid
      expect(user.errors[:password]).to include("を入力してください")
    end
    it "emailが空白の場合にバリデーションチェックされ空白のエラーメッセージが返ってきているか" do
      user = User.new(name: "taro", email: "", encrypted_password: "hogehoge")
      expect(user).to be_invalid
      expect(user.errors[:email]).to include("を入力してください")
    end
  end
  
  context "一意性のバリデーションチェック" do
    before do
      @user = FactoryBot.build(:user)
    end
    it "同じemailは登録できない" do
      @user.save
      another_user = FactoryBot.build(:user)
      another_user.email = @user.email
      expect(another_user).to be_invalid
      expect(another_user.errors[:email]).to include("はすでに存在します")
    end
  end
end