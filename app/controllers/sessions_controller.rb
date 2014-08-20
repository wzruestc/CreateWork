class SessionsController < ApplicationController
  def new
    if signed_in?
      redirect_to studentsWork_path
    end
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_back_or user
    else
      flash.now[:error] = '帐号或者密码错误！请重新输入'
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end
end
