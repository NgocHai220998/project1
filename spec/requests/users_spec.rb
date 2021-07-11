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

    it "同じemailは登録出来ない" do
      params = {"user" =>{"email"=>"user10@gmail.com", "nickname"=>"user1", "password"=>"User1234567890", "password_confirmation"=>"User1234567890"}}
      
      post(users_path, params: params)

      expect(response).to render_template('shared/_error_messages')
      expect(response).to render_template('users/new')
    end

    it "同じニックネームは登録出来ない" do
      params = {"user" =>{"email"=>"user2@gmail.com", "nickname"=>"user10", "password"=>"User1234567890", "password_confirmation"=>"User1234567890"}}

      post(users_path, params: params)
      
      expect(response).to render_template('shared/_error_messages')
      expect(response).to render_template('users/new')
    end

    it "パスワードが大文字なし" do
      params = {"user" =>{"email"=>"user3@gmail.com", "nickname"=>"user3", "password"=>"user1234567890", "password_confirmation"=>"user1234567890"}}
      
      post(users_path, params: params)
      
      expect(response).to render_template('shared/_error_messages')
      expect(response).to render_template('users/new')
    end

    it "パスワードが小文字なし" do
      params = {"user" =>{"email"=>"user4@gmail.com", "nickname"=>"user4", "password"=>"USER1234567890", "password_confirmation"=>"USER1234567890"}}
      
      post(users_path, params: params)
      
      expect(response).to render_template('shared/_error_messages')
      expect(response).to render_template('users/new')
    end

    it "パスワードが英数字なし" do
      params = {"user" =>{"email"=>"user5@gmail.com", "nickname"=>"user5", "password"=>"userUserUser", "password_confirmation"=>"userUserUser"}}
      
      post(users_path, params: params)
      
      expect(response).to render_template('shared/_error_messages')
      expect(response).to render_template('users/new')
    end

    it "パスワードの長さが条件を満たない" do
      params = {"user" =>{"email"=>"user6@gmail.com", "nickname"=>"user6", "password"=>"user123", "password_confirmation"=>"user123"}}
      
      post(users_path, params: params)
      
      expect(response).to render_template('shared/_error_messages')
      expect(response).to render_template('users/new')
    end

    it "パスワードと確認パスワードが違い" do
      params = {"user" =>{"email"=>"user7@gmail.com", "nickname"=>"user7", "password"=>"user123567890", "password_confirmation"=>"user4561237890"}}
      
      post(users_path, params: params)
      
      expect(response).to render_template('shared/_error_messages')
      expect(response).to render_template('users/new')
    end

    it "登録成功" do
      params = {"user" =>{"email"=>"ngadt167304@gmail.com", "nickname"=>"nga", "password"=>"Nga1234567890", "password_confirmation"=>"Nga1234567890"}}
      post(users_path, params: params)
      expect(response).to redirect_to(root_path)
    end
  end
end
