require 'rails_helper'

RSpec.describe "Relationshipモデルのテスト", type: :model do
  describe "バリデーションのテスト" do
    let(:user) { FactoryBot.create(:user) }
    let(:other_user) { FactoryBot.create(:user) }
    let(:relationship) { user.relationship.build(followed_id: other_user.id) }

    context "実際に保存する" do
      it "有効な値の場合保存されるか" do
        expect(FactoryBot.build(:relationship, following: user, follower: other_user)).to be_valid
      end
    end

    context "空白のバリデーションチェック" do
      it "follower_idが空白の場合にバリデーションチェックされるか" do
        relationship = Relationship.new(follower_id: "", following_id: "2")
        expect(relationship).to be_invalid
      end


      it "following_idが空白の場合にバリデーションチェックされるか" do
        relationship = Relationship.new(follower_id: "1", following_id: "")
        expect(relationship).to be_invalid
      end
    end
  end
end