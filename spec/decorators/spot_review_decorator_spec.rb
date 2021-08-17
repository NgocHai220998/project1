# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SpotReviewDecorator do
  describe 'publication_status' do
    it 'posted_atの値を表示する' do
      spot_review = SpotReview.new(posted_at: '2021-08-18')
      decorated_spot_review = ActiveDecorator::Decorator.instance.decorate(spot_review)

      expect(decorated_spot_review.publication_status).to eq('投稿されたに2021年08月18日')
    end
  end
end
