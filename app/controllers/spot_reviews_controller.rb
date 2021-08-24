class SpotReviewsController < ApplicationController
  def new
    @spot_review = SpotReview.new
  end

  def create
    if logged_in?
      @spot_review = SpotReview.new(post_params)
      handle_save
    else
      flash[:dager] = 'ログイン必要'
      redirect_to login_url
    end
  end

  private

  def post_params
    params.permit(:comment, :user_id, :spot_id)
  end

  def handle_save
    check = SpotReview.check_spot_review_max(post_params[:spot_id], @current_user.id)

    if check
      flash[:danger] = 'それぞれのユーザーがそれぞれのスポートにレービューを書く数が３回だけです。'
      redirect_to root_path
    else
      @spot_review.save
      redirect_to spot_path(post_params[:spot_id])
    end
  end
end
