require 'rails_helper'
include Capybara::RSpecMatchers

RSpec.describe "Users", type: :request do
  describe "登録" do
    let!(:user1) do
      user = FactoryBot.create(:user, email: "user10@gmail.com", nickname: "user10", password: "User1234567890", password_confirmation: "User1234567890")
    end

    before(:each) do
      get '/signup'
    end

    it "リクエストが成功すること" do
      expect(response).to have_http_status(200)
    end

    subject do
      post users_path, params: {user: {
        email: email,
        nickname: nickname,
        password: password,
        password_confirmation: password_confirmation
      }}
      response.body
    end

    let(:email) {}
    let(:nickname) {}
    let(:password) {}
    let(:password_confirmation) {}

    context "同じemailは登録出来ない" do
      let(:email) {"user10@gmail.com"}
      let(:nickname) {"user1"}
      let(:password) {"User1234567890"}
      let(:password_confirmation) {"User1234567890"}

      it "結果が正しいこと" do
        is_expected.to render_template('shared/_error_messages')
        is_expected.to have_content("メールはすでに存在します")
        is_expected.to render_template('users/new')
      end
    end

    context "同じニックネームは登録出来ない" do
      let(:email) {"user2@gmail.com"}
      let(:nickname) {"user10"}
      let(:password) {"User1234567890"}
      let(:password_confirmation) {"User1234567890"}

      it "結果が正しいこと" do
        is_expected.to render_template('shared/_error_messages')
        is_expected.to have_content("ニックネームはすでに存在します")
        is_expected.to render_template('users/new')
      end
    end

    context "パスワードが大文字なし" do
      let(:email) {"user3@gmail.com"}
      let(:nickname) {"user3"}
      let(:password) {"user1234567890"}
      let(:password_confirmation) {"user1234567890"}

      it "結果が正しいこと" do
        is_expected.to render_template('shared/_error_messages')
        is_expected.to have_content("パスワードは英数字大文字小文字が1文字以上、長さは12文字以上含む必要があります")
        is_expected.to render_template('users/new')
      end
    end

    context "パスワードが小文字なし" do
      let(:email) {"user4@gmail.com"}
      let(:nickname) {"user4"}
      let(:password) {"USER1234567890"}
      let(:password_confirmation) {"USER1234567890"}

      it "結果が正しいこと" do
        is_expected.to render_template('shared/_error_messages')
        is_expected.to have_content("パスワードは英数字大文字小文字が1文字以上、長さは12文字以上含む必要があります")
        is_expected.to render_template('users/new')
      end
    end

    context "パスワードが英数字なし" do
      let(:email) {"user5@gmail.com"}
      let(:nickname) {"user5"}
      let(:password) {"userUserUser"}
      let(:password_confirmation) {"userUserUser"}

      it "結果が正しいこと" do
        is_expected.to render_template('shared/_error_messages')
        is_expected.to have_content("パスワードは英数字大文字小文字が1文字以上、長さは12文字以上含む必要があります")
        is_expected.to render_template('users/new')
      end
    end

    context "パスワードの長さが条件を満たない" do
      let(:email) {"user6@gmail.com"}
      let(:nickname) {"user6"}
      let(:password) {"user123"}
      let(:password_confirmation) {"user123"}

      it "結果が正しいこと" do
        is_expected.to render_template('shared/_error_messages')
        is_expected.to have_content("パスワードは12文字以上で入力してください")
        is_expected.to render_template('users/new')
      end
    end

    context "パスワードと確認パスワードが違い" do
      let(:email) {"user7@gmail.com"}
      let(:nickname) {"user7"}
      let(:password) {"user123567890"}
      let(:password_confirmation) {"user4561237890"}

      it "結果が正しいこと" do 
        is_expected.to render_template('shared/_error_messages')
        is_expected.to have_content("確認パスワードとパスワードの入力が一致しません")
        is_expected.to render_template('users/new')
      end
    end

    context "登録成功" do
      let(:email) {"ngadt167304@gmail.com"}
      let(:nickname) {"nga"}
      let(:password) {"Nga1234567890"}
      let(:password_confirmation) {"Nga1234567890"}

      it "結果が正しいこと" do
        is_expected.to redirect_to(root_path)
      end
    end
  end
end
