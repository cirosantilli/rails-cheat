require 'test_helper'

class Controller0Test < ActionDispatch::IntegrationTest
  def teardown
    super
    Capybara.use_default_driver
  end

  def test_action0
    Capybara.current_driver = :poltergeist
    visit action0_path
    assert find('#application-css').visible?
    #controller0-scss
  end
end
