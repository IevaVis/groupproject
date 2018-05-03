class WelcomeController < ApplicationController
  
  def index
  	@articles = Article.all
    @tags = @articles.map {|article| article.tags}.flatten.uniq
    if params[:search]
      @articles = Article.search(params[:search]).order("created_at DESC")
    elsif params[:tag]
      @articles = Article.tag_search(params[:tag])
    else
      @articles = Article.all.order("created_at DESC")
    end
	end

end
