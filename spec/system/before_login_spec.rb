require "rails_helper"

describe "ユーザーログイン前のテスト" do
  describe "ユーザー新規登録のテスト" do
    before do
      visit new_user_registration_path
    end

    context "表示内容の確認" do
      it "nameフォームが表示される" do
        expect(page).to have_field "user[name]"
      end
      it "emailフォームが表示される" do
        expect(page).to have_field "user[email]"
      end
      it "passwordフォームが表示される" do
        expect(page).to have_field "user[password]"
      end
      it "password_confirmationフォームが表示される" do
        expect(page).to have_field "user[password_confirmation]"
      end
    end
    
    context "新規登録成功のテスト" do
      before do
        fill_in "user[name]", with: Faker::Lorem.characters(number: 10)
        fill_in "user[email]", with: Faker::Internet.email
        fill_in "user[password]", with: "password"
        fill_in "user[password_confirmation]", with: "password"
      end
      
      it "正しく新規登録される" do
        expect { click_button "新規登録" }.to change(User.all, :count).by(1)
      end
      it "新規登録後のリダイレクト先が、登録したユーザーの詳細画面になっている" do
        click_button "新規登録"
        expect(current_path).to eq "/users/" + User.last.id.to_s
      end
    end
  end

  describe "ユーザーログイン" do
    let(:user) { FactoryBot.create(:user) }
    
    before do
      visit new_user_session_path
    end
    
    context "ログイン成功のテスト" do
      before do
        fill_in "user[email]", with: user.email
        fill_in "user[password]", with: user.password
        click_button "ログイン"
      end
      
      it "ログイン後のリダイレクト先が、ログインしたユーザーの詳細画面になっている" do
        expect(current_path).to eq "/users/" + user.id.to_s
      end
    end
    
    context "ログイン失敗のテスト" do
      before do
        fill_in "user[email]", with: ""
        fill_in "user[password]", with: ""
        click_button "ログイン"
      end
      
      it "ログインに失敗した際、ログイン画面にリダイレクト" do
        expect(current_path).to eq "/sign_in"
      end
    end
  end
end 
