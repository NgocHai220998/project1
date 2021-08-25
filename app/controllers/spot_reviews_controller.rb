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

  def hanle_save
    @spot_review.id_spot = post_params[:spot_id]
    @spot_review.id_user = current_user.id
    @spot_review.save
    redirect_to spot_path(post_params[:spot_id])
  end
end
