class NewsPagesController < ApplicationController
  def index
  end

  def department
  end

  def mainBody
  end

  def news
    if signed_in?
      @user = current_user
      @articles = @user.articles.paginate(:page => params[:page], :per_page => 8)
    else
      flash.now[:error] = '您尚未登录！请您登录！'
      render 'sessions/new'
    end
  end

  def studentsWork
    if !signed_in?
      flash.now[:error] = '您尚未登录！请您登录！'
      render 'sessions/new'
    end
  end
end
