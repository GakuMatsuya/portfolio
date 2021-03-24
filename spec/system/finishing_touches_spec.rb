require 'rails_helper'

describe "仕上げのテスト" do
  let(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:review) { create(:review, user: user) }
  let!(:other_review) { create(:review, user: other_user) }
  let!(:item) { create(:item) }

  describe "サクセスメッセージのテスト" do
    subject { page }

    it "ユーザー新規登録成功時" do
      visit new_user_registration_path
      fill_in "user[name]", with: Faker::Name.name
      fill_in "user[email]", with: "a" + user.email   #user,other_userと違う値にするため
      fill_in "user[password]", with: "password"
      fill_in "user[password_confirmation]", with: "password"
      click_button "新規登録"
      is_expected.to have_content "登録が完了しました"
    end

    it "ユーザーログイン成功時" do
      visit new_user_session_path
      fill_in "user[email]", with: user.email
      fill_in "user[password]", with: user.password
      click_button "ログイン"
      is_expected.to have_content "ログインしました"
    end

    it "ユーザーログアウト成功時" do
      visit new_user_session_path
      fill_in "user[email]", with: user.email
      fill_in "user[password]", with: user.password
      click_button "ログイン"
      logout_link = find_all("a")[3].native.inner_text
      click_link logout_link
      is_expected.to have_content "ログアウトしました"
    end
    
    it "ユーザーのプロフィール更新成功時" do
      visit new_user_session_path
      visit new_user_session_path
      fill_in "user[email]", with: user.email
      fill_in "user[password]", with: user.password
      click_button "ログイン"
      visit edit_user_path(user)
      click_button "編集内容を保存"
      is_expected.to have_content "変更内容を保存しました"
    end
    
    it "投稿レビューの更新成功時" do
      visit new_user_session_path
      visit new_user_session_path
      fill_in "user[email]", with: user.email
      fill_in "user[password]", with: user.password
      click_button "ログイン"
      visit edit_item_review_path(item, review)
      click_button "変更する"
      is_expected.to have_content "変更内容を保存しました"
    end
  end

  describe "処理失敗時のテスト" do
    context "ユーザー新規登録失敗: passwordを5文字にする" do
      before do
        visit new_user_registration_path
        @password = Faker::Lorem.characters(number: 5)
        fill_in "user[name]", with: Faker::Name.name
        fill_in "user[email]", with: "a" + user.email  #user,other_userと違う値にするため
        fill_in "user[password]", with: @password
        fill_in "user[password_confirmation]", with: @password
      end
      
      it "新規登録されない" do
        expect { click_button "新規登録" }.not_to change(User.all, :count)
      end
      
      it "バリデーションエラーが表示される" do
        click_button "新規登録"
        expect(page).to have_content "6文字以上で入力してください"
      end
    end
  end
end