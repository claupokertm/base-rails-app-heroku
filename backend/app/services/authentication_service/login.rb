module AuthenticationService
  class Login < OpenStruct
    def process
      self.user = User.find_by(username: params[:username]&.downcase)
      unless user&.authenticate(params[:password])
        self.user = nil
      end
      self
    end
  end
end