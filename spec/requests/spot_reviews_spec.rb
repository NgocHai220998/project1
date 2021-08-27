require 'rails_helper'

RSpec.describe 'SpotReviews', type: :request do
  let(:user) do
    FactoryBot.create(:user)
  end

  let(:spot) do
    FactoryBot.create(:spot, :with_spot_review, :with_spot_schedule, reviews_count: current_reviews_count, user_id: user.id, start_on: Time.zone.now - 11.days, end_on: Time.zone.now - 5.days)
  end

  context 'ログインしている場合' do
    before do
      post login_path, params: {session: {
        email: user.email,
        password: user.password
      }}
    end

    subject do
      post spot_reviews_path, params: {
        spot_id: spot.id,
        comment: 'レビューのコメント'
      }
    end

    context 'current_reviews_count < 3 場合' do
      let(:current_reviews_count) { 2 }
  
      it 'レビューを書くことができる' do
        expect{ subject }.to change { spot.spot_reviews.count }.from(2).to(3)
      end
    end

    context 'current_reviews_count = 3の場合' do
      let(:current_reviews_count) { 3 }

      it 'レビューを書くことができない' do
        expect{ subject }.not_to change { spot.spot_reviews.count }
      end
    end

  end

  context 'ログインしない場合' do
    let(:current_reviews_count) { 2 }

    subject do
      post spot_reviews_path, params: {
        spot_id: spot.id,
        comment: 'レビューのコメント'
      }
      response.body
    end

    it "レビューを書くことができない" do
      is_expected.to redirect_to(login_url)
    end
  end
end
