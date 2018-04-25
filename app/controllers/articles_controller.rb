class ArticlesController < ApplicationController
  # require 'uri-open'
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :confirm_signed_in, only: [:new, :create]
  before_action :noko_parse, only: [:create]

  # GET /articles
  # GET /articles.json
  def index
    @articles = Article.all
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles
  # POST /articles.json
  def create
    @article = Article.new(article_params)

    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: 'Article was successfully created.' }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to @article, notice: 'Article was successfully updated.' }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url, notice: 'Article was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params[:article][:tags] = params[:article][:tags].split(",") unless params[:article][:tags].blank?
      params.require(:article).permit(:user_id, :link, :title, :image, :is_active, :tags => [])
    end

    # Make sure we have a user signed in
    def confirm_signed_in
      if !signed_in?
        redirect_to root_path
      end
    end

    def file_upload
      p params[:article][:image]
      if !params[:article][:image].blank?
        uploader = AvatarUploader.new
        uploader.store!(params[:article][:image])
      end
    end

    def noko_parse
      if !params[:article][:link].blank?
        doc = Nokogiri::HTML(open(params[:article][:link]))
        contents = doc.search("meta[property='og:title']", "meta[property='og:image']").map { |n| n["content"] }
        params[:article][:title] = contents[0]
        params[:article][:image] = contents[1]
        file_upload
      else
        redirect_to new_article_path, :flash => {:error => "Error creating article"}
      end
    end

end
