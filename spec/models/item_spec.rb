require 'rails_helper'

RSpec.describe "Itemモデルのテスト", type: :model do
  describe "実際に保存してみる" do
    it "有効な内容の場合保存されるか" do
      expect(FactoryBot.build(:item)).to be_valid
    end
  end

  context "空白のバリデーションチェック" do
    it "nameが空白の場合にバリデーションチェックされ空白のエラーメッセージが返ってきているか" do
      item = Item.new(name: "", genre_id: "1", image_id: "hoge", introduction: "hoge")
      expect(item).to be_invalid
      expect(item.errors[:name]).to include("を入力してください")
    end
    it "image_idが空白の場合にバリデーションチェックされエラーメッセージが返ってきているか" do
      item = Item.new(name: "hoge", genre_id: "1", image_id: "", introduction: "hoge")
      expect(item).to be_invalid
      expect(item.errors[:image]).to include("を入力してください")
    end
    it "introductionが空白の場合にバリデーションチェックされエラーメッセージが返ってきているか" do
      item = Item.new(name: "hoge", genre_id: "1", image_id: "hoge", introduction: "")
      expect(item).to be_invalid
      expect(item.errors[:introduction]).to include("を入力してください")
    end
  end
end
