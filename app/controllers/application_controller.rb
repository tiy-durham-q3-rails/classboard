class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def require_login
    unless current_user
      redirect_to login_path, alert: "You must be logged in to do that."
    end
  end

  def require_teacher
    unless teacher?
      redirect_to login_path, alert: "You must be logged in as a teacher to do that."
    end
  end

  helper_method :current_user, :teacher?

  def current_user
    if session[:user_id]
      begin
        @current_user ||= User.find(session[:user_id])
      rescue ActiveRecord::RecordNotFound
        session[:user_id] = nil
      end
    end

    @current_user
  end

  def teacher?
    current_user.try(:teacher?)
  end
end
