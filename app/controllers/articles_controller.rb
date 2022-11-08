class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update]
  
  def index
    @articles = Article.active.order("#{sort_column} #{sort_direction}")
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.employee = current_user
    if @article.save
      flash[:notice] = 'お知らせを投稿しました'
      redirect_to articles_path
    else 
      flash.now[:alert] = '投稿に失敗しました。'
      render :new
    end
  end

  def show
  end

  def edit

  end

  def update

  end

  def destroy

  end

  private

  def article_params
    params.require(:article).permit(:title, :content, :deleted_at, :employee_id)
  end

  def sort_column
    params[:sort] ? params[:sort] : 'created_at'
  end

  def sort_direction
    params[:direction] ? params[:direction] : 'asc'
  end

  def set_article
    @article = Article.find(params[:id])
  end
end
