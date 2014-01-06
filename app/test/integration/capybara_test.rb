require 'test_helper'

class CapybaraTest < ActionDispatch::IntegrationTest
  test "main" do
    path = "/controller0/capybara"
    visit path

    ##page

      ##has_content

        # Ignores HTML tags. Can also consider visibility with extra options.

          assert page.has_content?("paragraph")
          assert(!page.has_content?("<p>"))

    assert page.title =~ /^\s*capybara title/

    ##click_link

        click_link('a-id')
        assert current_path = '/'
        visit path
  end
end
