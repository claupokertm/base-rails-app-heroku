class ApplicationController < ActionController::Base
  include ApplicationHelper
  protect_from_forgery with: :exception

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def require_current_user
    if current_user.nil?
      redirect_to(authentication_login_path)
    end
  end

  protected :current_user
  helper_method :current_user
end
