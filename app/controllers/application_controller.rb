class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :login?

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def required_login
    unless login?
      flash[:info] = "你还没登录"
      redirect_to signin_path
    end
  end

  def login_as(user)
    session[:user_id] = user.id
    @current_user = user
  end

  def login?
    !!current_user
  end

  def logout
    session.delete(:user_id)
  end
end
