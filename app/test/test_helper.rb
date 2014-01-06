ENV["RAILS_ENV"] ||= "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  ActiveRecord::Migration.check_pending!

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...

  ##DatabaseCleaner setup

    # Typical DatabaseCleaner patterns used here:

      DatabaseCleaner.strategy = :truncation

      #def setup
        #DatabaseCleaner.start
        #Model0.create(...)
      #end

      #def teardown
        #DatabaseCleaner.clean
      #end

  #factory_girl
  include FactoryGirl::Syntax::Methods

  #capybara
  include Capybara::DSL
end
