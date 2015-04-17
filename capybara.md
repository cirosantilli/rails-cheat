# Capybara

Recommended location for tests are: `test/integration` for Minitest `spec/features` for RSpec tests, or `features` for Spinach tests.

Minimal Rails integration tests can be found in this repository under: [test/integration/capybara_test.rb](test/integration/capybara_test.rb).

rspec-rails integration tests can be found at: [spec/integration/capybara_spec.rb](spec/integration/capybara_spec.rb).

Like other integration tests, Capybara tests can be run with `rake test:integration`, which is called by `rake test`.

As of Rails 4.1, the only use case for it tests that depend on JavaScript, since Rails now has HTML-only tests like `assert_select` built-in.
