require 'test_helper'

class CapybaraTest < ActionDispatch::IntegrationTest
  test "main" do
    path = "/capybara"
    visit path
    assert title.include?('capybara title')
  end
end
