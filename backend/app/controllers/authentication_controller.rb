class AuthenticationController < ApplicationController
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
    login = AuthenticationService::Login.new(params: params).process

    if login.user.present?
      set_session(login.user)
      redirect_to_js(root_path, 'Welcome!')
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

  def set_session(user)
    session[:user_id] = user.id
  end
end