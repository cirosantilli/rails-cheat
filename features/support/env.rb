ENV['RAILS_ENV'] = 'test'
require './config/environment'

require 'minitest/spec'

# To use with rspec:
#require 'rspec'

# require 'database_cleaner'
# DatabaseCleaner.strategy = :truncation
#
# Spinach.hooks.before_scenario{ DatabaseCleaner.clean }
#
# Spinach.config.save_and_open_page_on_failure = true
