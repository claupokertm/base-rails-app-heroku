RailsAdmin.config do |config|

  config.authenticate_with do
    check_logged_in
  end
  config.current_user_method(&:current_user)

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
end

RailsAdmin::MainController.class_eval do
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def check_logged_in
    if current_user.nil? || !current_user.admin?
      redirect_to '/'
    end
  end
end