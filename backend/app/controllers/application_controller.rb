class ApplicationController < ActionController::Base
  include ApplicationHelper
  protect_from_forgery with: :exception

  def current_user
    @current_user ||= User.find_by(session[:user_id])
  end

  protected :current_user
  helper_method :current_user
end
