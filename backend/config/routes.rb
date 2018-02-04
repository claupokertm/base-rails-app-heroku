Rails.application.routes.draw do
  root 'dashboard#index'

  namespace :authentication do
    get '', action: :login, as: :login
    get '/register', action: :register, as: :register
    post '/register', action: :register_post, as: :register_post
    post '', action: :login_post, as: :login_post
    delete '', action: :logout, as: :logout
  end
end
