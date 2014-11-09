source 'https://rubygems.org'

#ruby '2.1.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.0'

# DBMS:
instance_eval(File.read(File.join(File.dirname(__FILE__), 'Gemfile_dbms')))

# Use SCSS for stylesheets
gem 'sass-rails'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails'

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Every internal <a> link makes the body reloadvia AJAX instead of reloading the entire page.
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

#== END of default template =============================

# Deployment
gem 'foreman'
gem 'unicorn'
#gem 'unicorn-rails'

# Login
gem 'devise'
gem 'omniauth'
gem 'omniauth-google-oauth2'
gem 'omniauth-facebook'

gem 'breadcrumbs_on_rails'
#gem 'counter_culture'
gem 'gon'
gem 'haml-rails'
gem 'settingslogic'

# TODO get rid of this: not Rails specific.
gem 'faker'

group :development, :test do
  gem 'seed-fu'
end

group :development do
  gem 'letter_opener'

  gem 'guard-minitest', group: :development
  #gem 'guard-test', group: :development
  #gem 'guard-rspec', group: :development

  gem 'spring', group: :development
end

# Tests
group :test do
  gem 'capybara'
  gem 'database_cleaner'
  gem 'factory_girl_rails'
  gem 'minitest-rails'
  gem 'poltergeist', '1.5.1'
  gem 'rspec-rails'
  gem 'spinach-rails'
end
