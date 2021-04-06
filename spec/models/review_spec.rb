require 'rails_helper'

RSpec.describe "Reviewモデルのテスト", type: :model do
  describe "実際に保存してみる" do
    it "有効な内容の場合保存されるか" do
      expect(FactoryBot.build(:review)).to be_valid
    end
  end

  context "空白のバリデーションチェック" do
    it "rateが空白の場合にバリデーションチェックされ空白のエラーメッセージが返ってきているか" do
      review = Review.new(item_id: "1", user_id: "1", rate: "", text: "hoge")
      expect(review).to be_invalid
      expect(review.errors[:rate]).to include("を入力してください")
    end
    it "textが空白の場合にバリデーションチェックされエラーメッセージが返ってきているか" do
      review = Review.new(item_id: "1", user_id: "1", rate: "1.5", text: "")
      expect(review).to be_invalid
      expect(review.errors[:text]).to include("を入力してください")
    end
  end

  context "rateの数値範囲をチェック" do
    it "rateが0.5未満のときバリデーションチェックされる" do
      review = Review.new(item_id: "1", user_id: "1", rate: "0", text: "hoge")
      expect(review).to be_invalid
    end
    it "rateが5より大きいときバリデーションチェックされる" do
      review = Review.new(item_id: "1", user_id: "1", rate: "6", text: "hoge")
      expect(review).to be_invalid
    end
  end
end
