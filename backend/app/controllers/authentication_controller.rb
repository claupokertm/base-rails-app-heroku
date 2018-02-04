class AuthenticationController < ApplicationController
  def login_post
    @username = params[:username]
    login = AuthenticationService::Login.new(params: params).process

    if login.user.present?
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

  def login_callback_github
    login = AuthenticationService::LoginFromGithub.new(auth: request.env['omniauth.auth']).process
    if login.user.present?
      set_session(login.user)
      flash[:success] = 'Welcome'
      respond_to do |format|
        format.html { redirect_to_dashboard(login.user) }
        format.json { render json: login.user }
      end
    end
  end

  def login_callback_steam
    login = AuthenticationService::LoginFromSteam.new(auth: request.env['omniauth.auth']).process
    if login.user.present?
      set_session(login.user)
      flash[:success] = 'Welcome'
      respond_to do |format|
        format.html { redirect_to_dashboard(login.user) }
        format.json { render json: login.user }
      end
    end
  end

  def logout
    session[:user_id] = nil
    flash[:success] = 'Logged out'
    if current_admin.present?
      respond_to do |format|
        format.html { redirect_to users_path }
        format.json { head 200 }
      end
    else
      respond_to do |format|
        format.html { redirect_to authentication_login_path }
        format.json { head 200 }
      end
    end
  end

  def logout_admin
    session[:admin_id] = nil
    flash[:success] = 'Logged out from admin'
    redirect_to authentication_login_path
  end

  def redirect_to_dashboard(user=current_user)
    return if user.nil?

    if user.basic?
      redirect_to root_path
    else
      redirect_to users_path
    end
  end

  def set_session(user)
    if user.basic? || user.manager?
      session[:user_id] = user.id
    elsif user.admin?
      session[:admin_id] = user.id
    end
  end
end