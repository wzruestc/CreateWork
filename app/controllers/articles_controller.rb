class ArticlesController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy
  before_action :admin_user,     only: :destroy

  def create
    @article = current_user.articles.build(article_params)
    if @article.save
      flash[:success] = '文章发布成功！'
      redirect_to news_path
    else
      flash[:error] = '文章发布失败！请重试！'
      redirect_to edit_path
    end
  end

  def destroy
  end

  private

  def article_params
    params.require(:article).permit(:title, :content)
  end

  def correct_user
    @article = current_user.microposts.find_by(id: params[:id])
    redirect_to news_url if @article.nil?
  end

  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end
end