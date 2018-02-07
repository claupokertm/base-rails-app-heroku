module Dashboard
  class ProfileController < Dashboard::BaseController
    def update
      profile = UsersService::UpdateProfile.new(params, current_user).process
      if profile.errors.present?
        render_form_errors_js(profile)
      end
    end
  end
end