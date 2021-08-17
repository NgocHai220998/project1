module SpotReviewDecorator
  def publication_status
    if posted_at?
      "投稿されたに#{posted_at.strftime('%Y年%m月%d日')}"
    else
      "まだ投稿されない"
    end
  end
end
