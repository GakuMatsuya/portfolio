require 'rails_helper'

RSpec.describe "Adminモデルのテスト", type: :model do
  describe "バリデーションのテスト" do
    it "emailが空白の場合にバリデーションチェックされ空白のエラーメッセージが返ってきているか" do
      admin = Admin.new(email: "", encrypted_password: "hogehoge")
      expect(admin).to be_invalid
      expect(admin.errors[:email]).to include("を入力してください")
    end
    it "passwordが空白の場合にバリデーションチェックされるか" do
      admin = Admin.new(email: "hogehoge@mail.com", password: "")
      expect(admin).to be_invalid
    end
  end
end
