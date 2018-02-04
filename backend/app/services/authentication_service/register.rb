module AuthenticationService
  class Register
    include ActiveModel::Validations
    attr_reader :username, :password, :password_repeat, :email
    attr_accessor :user
    validate :unique_username, :passwords_match
    validates :username, presence: true, length: {
        minimum: 4,
        maxiumum: 32
    }

    validates :password, presence: true, length: {
        minimum: 8,
        maxiumum: 32
    }

    validates :email, presence: true, format: {
      with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
    }

    def initialize(params = {})
      @username = params[:username]&.downcase
      @email = params[:email]&.downcase
      @password = params[:password]
      @password_repeat = params[:password_repeat]
    end

    def process
      if valid?
        self.user = User.create(username: username, password: password, email: email)
      end
      self
    end

    def unique_username
      if User.find_by(username: username)
        errors.add(:username, 'There is already a user with that username')
      end
    end

    def passwords_match
      if password != password_repeat
        errors.add(:password_repeat, "Passwords don't match")
      end
    end
  end
end