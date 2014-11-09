require 'test_helper'

# The setup is done in the `test_helper`.

class CapybaraTest < ActionDispatch::IntegrationTest
  def test_main
    path = '/capybara'
    visit path
    assert title.include?('capybara title')
  end

  # To use the Js capable driver with Minitest,
  # you must use the verbose method since it is not possible to use `js: true` like on RSpec `it`:
  # http://stackoverflow.com/questions/5655154/how-do-you-perform-javascript-tests-with-minitest-capybara-selenium

    def teardown
      super
      Capybara.use_default_driver
    end

    def test_with_javascript
      Capybara.current_driver = :poltergeist
      execute_script('0')
    end

    def test_without_javascript
      assert_equal(Capybara.current_driver, :rack_test)
    end
end
