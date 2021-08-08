require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  describe "登録" do
    let!(:user1) do
      user = FactoryBot.create(:user, email: "user1@gmail.com", nickname: "user1", password: "User1234567890", password_confirmation: "User1234567890")
    end

    before(:each) do
      get '/login'
    end

    it "リクエストが成功すること" do
      expect(response).to have_http_status(200)
    end

    subject do
      post login_path, params: {session: {
        email: email,
        password: password
      }}
      response.body
    end

    let(:email) {}
    let(:password) {}

    context "emailが違う" do
      let(:email) {"user2@gmail.com"}
      let(:password) {"User1234567890"}

      it "結果が正しいこと" do
        is_expected.to render_template('sessions/new')
      end
    end

    context "パスワードが違う" do
      let(:email) {"user1@gmail.com"}
      let(:password) {"User12345678901"}

      it "結果が正しいこと" do
        is_expected.to render_template('sessions/new')
      end
    end

    context "ログイン成功" do
      let(:email) {"user1@gmail.com"}
      let(:password) {"User1234567890"}

      it "結果が正しいこと" do
        is_expected.to redirect_to(user1)
      end
    end
  end
end
