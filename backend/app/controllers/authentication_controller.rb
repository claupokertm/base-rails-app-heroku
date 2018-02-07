class AuthenticationController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :login_3rd_party

  def login_post
    @username = params[:username]
    login = AuthenticationService::Login.new(params: params).process

    if login.user.present?
      set_session(login.user)
      redirect_to_js(root_path, 'Welcome!')
    else
      render_error_js('Invalid Login');
    end
  end

  def register
    @email = params[:email]
  end

  def register_post
    @username = params[:username]
    @email = params[:email]

    register = AuthenticationService::Register.new(params).process

    if register.user
      set_session(register.user)
      redirect_to_js(root_path, 'Welcome!')
    else
      render_form_errors_js(register)
    end
  end

  def login_3rd_party
    login = AuthenticationService::ExternalLogin.new(auth: request.env['omniauth.auth']).process

    if login.user.present?
      set_session(login.user)
      redirect_to root_path
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to_js(authentication_login_path, 'Logged Out!')
  end

  def set_session(user)
    session[:user_id] = user.id
  end
end