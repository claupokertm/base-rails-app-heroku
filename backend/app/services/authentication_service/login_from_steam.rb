module AuthenticationService
  class LoginFromSteam < OpenStruct
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
      raw_info = auth['extra']['raw_info']

      @fields ||= {
          username: raw_info['personaname'],
          avatar_url: raw_info['avatar'],
          provider: 'steam',
          uid: auth['uid']
      }
    end
  end
end