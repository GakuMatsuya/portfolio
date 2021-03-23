require 'rails_helper'

describe "ユーザログイン後のテスト" do
  let!(:user) { create(:user) }
  let!(:review) { create(:review, user: user) }
  let!(:item) { create(:item) }

  before do
    visit new_user_session_path
    fill_in "user[email]", with: user.email
    fill_in "user[password]", with: user.password
    click_button "ログイン"
  end


  describe "新規投稿のテスト" do
    before do
      visit new_item_review_path(item)
    end

    context "投稿成功のテスト" do
      before do
        fill_in "review[text]", with: Faker::Lorem.characters(number:50)
        find("#star input", visible: false).set("1")
      end

      it "投稿に成功しサクセスメッセージが表示されるか" do
        expect { click_button "投稿する" }.to change(user.reviews, :count).by(1)
        expect(page).to have_current_path item_path(item)
        expect(page).to have_content "投稿しました"
      end
    end

    context "投稿失敗のテスト" do
      it "投稿に失敗する" do
        click_button "投稿する"
        expect(page).to have_content "エラー"
        expect(current_path).to eq("/items/2/reviews")
      end
    end
  end

  describe "投稿編集のテスト" do
    before do
      visit edit_item_review_path(item, review)
    end

    context "編集成功のテスト" do
      before do
        @review_old_text = review.text
        @review_old_rate = review.rate
        fill_in "review[text]", with: Faker::Lorem.characters(number: 50)
        find("#star input", visible: false).set("0.5")
        click_button "変更する"
      end

      it "reviewが正しく更新される" do
        expect(review.reload.text).not_to eq @review_old_text
      end

      it "rateが正しく更新される" do
        expect(review.reload.rate).not_to eq @review_old_rate
      end

      it "リダイレクト先が、更新した投稿の詳細画面になっている" do
        expect(current_path).to eq "/items/1/reviews/" + review.id.to_s
        expect(page).to have_content "保存しました"
      end
    end
  end
end