require 'rails_helper'

RSpec.describe "Commentモデルのテスト", type: :model do
  describe "実際に保存してみる" do
    it "有効な内容の場合保存されるか" do
      expect(FactoryBot.build(:comment)).to be_valid
    end
  end
  
  context "空白のバリデーションチェック" do
    it "textが空白の場合にバリデーションチェックされるか" do
      comment = Comment.new(text: "")
      expect(comment).to be_invalid
    end
  end
end