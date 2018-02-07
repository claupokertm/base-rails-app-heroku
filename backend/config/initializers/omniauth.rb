OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, Rails.application.secrets.facebook[:app_id], Rails.application.secrets.facebook[:app_secret]
  provider :google_oauth2, Rails.application.secrets.google[:app_id], Rails.application.secrets.google[:app_secret]
end