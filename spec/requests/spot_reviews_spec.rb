require 'rails_helper'

RSpec.describe "SpotReviews", type: :request do
  subject do
    post spot_reviews_path, params: {
      user_id: user_id,
      spot_id: spot_id,
      comment: comment
    }
  end

  let!(:user1) do
    FactoryBot.create(:user, email: "user111@gmail.com", nickname: "user111", password: "User1234567890", password_confirmation: "User1234567890")
  end

  let!(:spot1) do
    FactoryBot.create(:spot, :with_spot_review, :with_spot_schedule, reviews_count: 2, user_id: user1.id, start_on: Time.zone.now - 11.days, end_on: Time.zone.now - 5.days)
  end

  let(:user_id) { user1.id }
  let(:spot_id) { spot1.id }
  let(:comment) { "レビューのコメント" }

  describe "ログインしたユーザーがレビューする" do
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

    it "レビューを書くことができる" do
      expect{subject}.to change {spot1.spot_reviews.count}.from(2).to(3)
    end
  end

  describe "ログインしたユーザーが３以上レビューをする" do
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
      
    it "レビューを書くことができない" do
      expect{subject}.not_to change {spot1.spot_reviews.count}
    end
  end

  describe "ログインしない" do
    before(:each) do
      get spot_path(id: spot1.id)
    end
      
    it "レビューを書くことができない" do
      expect(response.body).to include("まだログインしないので、ログインしてください")
    end
  end
end
