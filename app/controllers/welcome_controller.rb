class WelcomeController < ApplicationController
  
  def index
  	@articles = Article.all
  	@article = Article.new
	end

end
