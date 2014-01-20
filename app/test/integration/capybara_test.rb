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

      # Title head element:

        assert page.title =~ /^\s*capybara title/

      # The raw body:

        #puts "page.body = " + page.body

    ##current_url

        #puts "current_url = " + current_url

    ##click_link

        click_link('a-id')
        assert current_path = '/'
        visit path

    # Save current page to a temporary file and open it in default browser.
    # Good way to debuge failing tests.

      #save_and_open_page
  end
end
