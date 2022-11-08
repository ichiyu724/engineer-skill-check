class ArticlesController < ApplicationController
  def index
    @articles = Article.all
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
end
