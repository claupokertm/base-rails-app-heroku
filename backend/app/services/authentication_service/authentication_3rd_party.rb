module AuthenticationService
  class Authentication3rdParty < OpenStruct
    def process
      case params[:provider]
        when 'facebook'
          self.user = AuthenticationService::ThirdParty::Facebook.new(params: params).process
        else
          nil
      end
      self
    end
  end
end