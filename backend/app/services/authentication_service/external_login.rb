module AuthenticationService
  class ExternalLogin < OpenStruct
    OAUTH_LIST = %w(facebook google_oauth2)
    def process
      if OAUTH_LIST.include?(auth[:provider])
        self.user = oauth(auth)
      end
      self
    end

    def oauth(auth)
      user = User.find_by(uid: auth.uid, provider: auth.provider)
      if user.nil?
        user = User.new(uid: auth.uid, provider: auth.provider)
      end

      user.email = auth.info.email
      user.username = auth.info.email
      user.avatar_url = auth.info.image
      user.verified = true
      user.name = auth.info.name
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      if user.password_digest.nil?
        user.password = SecureRandom.base64
      end
      user.save!
      user
    end
  end
end