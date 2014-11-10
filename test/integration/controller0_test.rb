require 'test_helper'

class Controller0Test < ActionDispatch::IntegrationTest
  def teardown
    super
    Capybara.use_default_driver
  end

  def test_action0
    Capybara.current_driver = :poltergeist
    visit action0_path
    refute find('#application-css', visible: false).visible?
    refute find('#controller0-scss', visible: false).visible?
  end
end
