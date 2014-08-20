class UsersController < ApplicationController
  before_action :signed_in_user, only: [:edit, :update]
  before_action :correct_user,   only: [:edit, :update]
  def new
    @user = User.find(params[:id])
    @articles = @user.articles.paginate(page: params[:page])
  end

  def show
    if signed_in?
      @user = User.find(params[:id])
      @articles = @user.articles.paginate(page: params[:page])
    else
      flash.now[:error] = '您尚未登录！请您登录！'
      render 'sessions/new'
    end
  end

  def articleEdit
    @article = current_user.articles.build if signed_in?
    if !signed_in?
      flash.now[:error] = '您尚未登录！请您登录！'
      render 'sessions/new'
    end
  end

  def administrator
    if signed_in?
      @user = current_user
      @articles = @user.articles.paginate(:page => params[:page], :per_page => 8)
    else
      flash.now[:error] = '您尚未登录！请您登录！'
      render 'sessions/new'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  # Before filters

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless current_user?(@user)
  end

  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end
end
