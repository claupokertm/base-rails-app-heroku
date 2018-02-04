module AuthenticationService
  class LoginFromGithub < OpenStruct
    def process
      self.user = User.find_by(username: fields[:username])
      if user
        user.update(fields)
      else
        self.user = User.create!(fields.merge(verified: true, password: SecureRandom.base64))
      end
      self
    end

    def fields
      @fields ||= {
        username: auth.info.name,
        oauth_token: auth.credentials.token,
        avatar_url: auth.info.image,
        provider: auth.provider,
        uid: auth.uid
      }
    end
  end
end