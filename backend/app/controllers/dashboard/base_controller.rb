module Dashboard
  class BaseController < ApplicationController
    before_action :require_current_user
  end
end