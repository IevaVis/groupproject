module ArticlesHelper

  def article_owner?(article)
    return signed_in? && current_user.id == article.user_id
  end

end
