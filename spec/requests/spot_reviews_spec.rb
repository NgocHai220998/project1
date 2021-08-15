require 'rails_helper'

RSpec.describe "SpotReviews", type: :request do
  describe "ログインしたユーザーが３以下レビューをする" do
    let!(:user1) do
      user = FactoryBot.create(:user, email: "user111@gmail.com", nickname: "user111", password: "User1234567890", password_confirmation: "User1234567890")
    end

    let!(:spot1) do
      FactoryBot.create(:spot, :with_spot_review, :with_spot_schedule, reviews_count: 2, user_id: user1.id, start_on: Time.zone.now - 11.days, end_on: Time.zone.now - 5.days)
    end

    before(:each) do
      post login_path, params: {session: {
        email: user1.email,
        password: user1.password
      }}
      get spot_path(id: spot1.id)
    end

    it "リクエストが成功すること" do
      expect(response).to have_http_status(200)
    end

    subject do
      post spot_reviews_path, params: {
        user_id: user_id,
        spot_id: spot_id,
        comment: comment
      }
      response.body
    end

    let(:user_id) { user1.id }
    let(:spot_id) { spot1.id }
    let(:comment) { "レビューのコメント" }

    it "結果が正しいこと" do
      is_expected.to redirect_to(spot_path(spot1.id))
    end
  end

  describe "ログインしたユーザーが３以下レビューをする" do
    let!(:user1) do
      user = FactoryBot.create(:user, email: "user111@gmail.com", nickname: "user111", password: "User1234567890", password_confirmation: "User1234567890")
    end

    let!(:spot1) do
      FactoryBot.create(:spot, :with_spot_review, :with_spot_schedule, reviews_count: 3, user_id: user1.id, start_on: Time.zone.now - 11.days, end_on: Time.zone.now - 5.days)
    end

    before(:each) do
      post login_path, params: {session: {
        email: user1.email,
        password: user1.password
      }}
      get spot_path(id: spot1.id)
    end

    subject do
      post spot_reviews_path, params: {
        user_id: user_id,
        spot_id: spot_id,
        comment: comment
      }
      response.body
    end

    let(:user_id) { user1.id }
    let(:spot_id) { spot1.id }
    let(:comment) { "レビューのコメント" }
      
    it "結果が正しいこと" do
      is_expected.to redirect_to(root_path)
    end
  end

  describe "ログインしない" do
    let!(:user1) do
      user = FactoryBot.create(:user, email: "user111@gmail.com", nickname: "user111", password: "User1234567890", password_confirmation: "User1234567890")
    end

    let!(:spot1) do
      FactoryBot.create(:spot, :with_spot_review, :with_spot_schedule, reviews_count: 3, user_id: user1.id, start_on: Time.zone.now - 11.days, end_on: Time.zone.now - 5.days)
    end

    before(:each) do
      get spot_path(id: spot1.id)
    end
      
    it "結果が正しいこと" do
      expect(response.body).to include("まだログインしないので、ログインしてください")
    end
  end
end
