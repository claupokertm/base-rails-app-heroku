module AuthenticationService::ThirdParty
  class Facebook < Openstruct
    def process
      p params
      User.first
    end
  end
end