# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  abort e.to_s.strip
end
RSpec.configure do |config|

  config.fixture_paths = [
    Rails.root.join('spec/fixtures')
  ]

  config.use_transactional_fixtures = true

  config.infer_spec_type_from_file_location!

  config.filter_rails_from_backtrace!

  Shoulda::Matchers.configure do |config|
    config.integrate do |with|
      with.test_framework :rspec
      with.library :rails
    end
  end 
  
  module APIRequestHelpers
    def api_sign_in(user, credential)
      post(
        "/sign_in",
        headers: {
          "Accept" => "application/json",
          "X-API-KEY" => credential.key
        },
        params: {
          login: {
            email: user.email,
            password: user.password
          }
        }
      )

      JSON.parse(response.body)
    end
  end
  
  config.include APIRequestHelpers, type: :request
  config.include Devise::Test::IntegrationHelpers, type: :request

  RSpec.configure do |config|
    config.include FactoryBot::Syntax::Methods
  end

end
