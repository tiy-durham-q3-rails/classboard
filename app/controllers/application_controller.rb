class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def require_login
    unless current_user
      redirect_to login_path, alert: "You must be logged in to do that."
    end
  end

  helper_method :current_user

  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end
end
