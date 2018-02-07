module UsersService
  class UpdateProfile
    include ActiveModel::Validations
    attr_reader :username, :avatar_url, :email, :name, :user
    attr_accessor :user
    validate :unique_username
    validates :username, presence: true, length: {
        minimum: 4,
        maxiumum: 32
    }

    validates :email, presence: true, format: {
        with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
    }

    validates :name, presence: true, length: {
        minimum: 2,
        maximum: 200
    }

    validates :avatar_url, format: URI::regexp(%w(http https))


    def initialize(params = {}, user)
      @username = params[:username]&.downcase
      @email = params[:email]&.downcase
      @name = params[:name]
      @avatar_url = params[:avatar_url]
      @user = user
    end

    def process
      if valid?
        self.user = user.update!(username: username, email: email, name: name, avatar_url: avatar_url)
      end
      self
    end

    def unique_username
      if User.where('id <> ?', user.id).where(username: username).count > 0
        errors.add(:username, 'There is already a user with that username')
      end
    end
  end
end