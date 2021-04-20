$LOAD_PATH.unshift(File.dirname(__FILE__))
ENV['RAILS_ENV'] ||= 'test'
require 'simplecov'
require 'coveralls'
Coveralls.wear! 'rails'

require File.expand_path("../dummy/config/environment.rb",  __FILE__)
require 'rspec/rails'
require 'shoulda-matchers'
require 'capybara/rails'
require 'capybara/rspec'
require 'database_cleaner'
require 'factory_bot_rails'
require 'rails-controller-testing'

require_relative 'dummy/app/admin/post'
require_relative 'dummy/app/admin/dashboard'
require_relative 'dummy/app/admin/admin_user'
require_relative 'dummy/app/admin/tag'
require_relative 'dummy/config/routes'

Rails.backtrace_cleaner.remove_silencers!

DatabaseCleaner.strategy = :truncation

Warden.test_mode!

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
  config.mock_with :rspec
  config.use_transactional_fixtures = true
  config.infer_base_class_for_anonymous_controllers = false
  config.order = "random"

  config.include FactoryBot::Syntax::Methods

  config.include ::Shoulda::Matchers::ActionController, type: :controller
  config.include AdminLoginControllerHelper,            type: :controller
  config.include AdminLoginIntegrationHelper,           type: :feature
  config.include Devise::Test::ControllerHelpers,       type: :controller
  config.include Warden::Test::Helpers,                 type: :feature

  [:controller, :view, :request].each do |type|
    config.include ::Rails::Controller::Testing::TestProcess,        type: type
    config.include ::Rails::Controller::Testing::TemplateAssertions, type: type
    config.include ::Rails::Controller::Testing::Integration,        type: type
  end

  config.after(:each, type: :request) do
    DatabaseCleaner.clean       # Truncate the database
    Capybara.reset_sessions!    # Forget the (simulated) browser state
    Capybara.use_default_driver # Revert Capybara.current_driver to Capybara.default_driver
  end
end
