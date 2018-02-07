require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
abort('The Rails environment is running in production mode!') if Rails.env.production?
require 'rspec/rails'
require 'capybara/poltergeist'
require 'rack_session_access/capybara'

ActiveRecord::Migration.maintain_test_schema!

module AuthHelper
  def authenticate_user(user)
    page.set_rack_session(user_id: user.id)
  end
end

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
  config.include AuthHelper
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end
end
Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

class ::Hash
  def method_missing(name)
    return self[name] if key? name
    self.each { |k,v| return v if k.to_s.to_sym == name }
    super.method_missing name
  end

  def permit(*names)
    new_hash = {}
    names.each do |name|
      new_hash[name] = self[name]
    end
  end
end

Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, phantomjs_logger: false)
end

Capybara.default_driver = :poltergeist
