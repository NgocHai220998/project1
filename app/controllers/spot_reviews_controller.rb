class SpotReviewsController < ApplicationController
  def create
    unless current_user
      flash[:dager] = "ログイン必要"
      user_login
    spot_review_create
  end

  private
  def spot_review_create
    @spot_review = SpotReview.new(params)
    if user.spot.spot_review <= 3
      if @spot_review.save
        redirect_to spot_path
      end
    else
      flash[:danger] = "それぞれのユーザーがそれぞれのスポートにレービューを書く数が３回だけです。"
    end
  end
end
