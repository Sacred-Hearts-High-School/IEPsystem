class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  layout :my_layout_setting

  def login_required
     unless logged_in?
        redirect_to "/users/login"
     end
  end

  def admin_required
     unless current_user.is_admin
        redirect_to root_path, alert: "您無權檢視該頁面，請先以管理者帳號登入！"
     end
  end

  def logged_in?
     session[:user_id]
  end

  private
  def current_user
     @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def my_layout_setting
     if logged_in? 
        "admin" if current_user.is_admin
        "application"
     else
        "application"
     end
  end

  helper_method :current_user


end
