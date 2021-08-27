class SpotReviewsController < ApplicationController
  before_action :logged_in_user, only: %i[create]

  def new
    @spot_review = SpotReview.new
  end

  def create
    @spot_review = current_user.spot_reviews.build(post_params)

    if @spot_review.save
      flash[:success] = 'レビューできました'
    else
      flash[:danger] = 'ユーザーがこのスポートにレービューを書く数が３回ので、もうレビューを書くことができない'
    end

    redirect_to spot_path(post_params[:spot_id])
  end

  private

  def post_params
    params.permit(:comment, :spot_id)
  end
end
