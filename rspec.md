# RSpec

RSpec is composed into multiple gems, and only <https://github.com/rspec/rspec-rails> will be commented here.

Install on `Gemfile`:

    group :development, :test do
      gem 'rspec-rails'
    end

Generate templates for `.rspec` and `spec/spec_helper.rb`.:

    rails generate rspec:install

Simple Rails integration examples can be found at: [spec/controllers/controller0_spec.rb](spec/controllers/controller0_spec.rb).

## RSpec prevents rendering for controller specs

<http://stackoverflow.com/questions/1063073/rspec-controller-testing-blank-response-body>

Therefore, `response.body` will be empty and `assert_select` will fail.
