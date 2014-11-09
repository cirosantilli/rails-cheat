require 'test_helper'

class Controller0Test < ActionDispatch::IntegrationTest
  test 'action0' do
    visit action0_path
    assert find('#application-css').visible?
    #controller0-scss
  end
end
