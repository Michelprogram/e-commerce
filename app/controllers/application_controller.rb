class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?
  include CartsHelper

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    current_user.present?
  end

  def require_user
    unless current_user
      flash[:alert] = "You must be logged in to access this section"
      redirect_to login_path
    end
  end
end
