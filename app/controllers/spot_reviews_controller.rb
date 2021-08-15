class SpotReviewsController < ApplicationController
  def new
    @spot_review = SpotReview.new
  end

  def create
    if logged_in?
      @spot_review = SpotReview.new(post_params)
      check_spot_review_max
    else
      flash[:dager] = 'ログイン必要'
      redirect_to login_url
    end
  end

  private

  def count_of_spot_review
    @spot = Spot.find_by(id: post_params[:spot_id])

    @spot.spot_reviews.select { |spot_review| spot_review.user_id == @current_user.id }.count
  end

  def check_spot_review_max
    if count_of_spot_review > 2
      flash[:danger] = 'それぞれのユーザーがそれぞれのスポートにレービューを書く数が３回だけです。'
      redirect_to root_path
    elsif @spot_review.save
      redirect_to spot_path(post_params[:spot_id])
    end
  end

  def post_params
    params.permit(:comment, :user_id, :spot_id)
  end
end
