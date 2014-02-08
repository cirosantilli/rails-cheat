require 'test_helper'

class CapybaraTest < ActionDispatch::IntegrationTest
  test "main" do
    path = "/controller0/capybara"
    visit path

    ##driver

      # Not all drivers support all functions.

      # Driver can be set under `support/env.rb`

        #Capybara.javascript_driver = :poltergeist

    ##visit

      # Go to an URL.

    ##current_url

        #puts "current_url = " + current_url

    ##page

      ##querying

        # http://rubydoc.info/github/jnicklas/capybara/master/Capybara/Node/Finders#all-instance_method

        ##within

          # Limits scope of search to matching elements.

            #within(:xpath, '//div[@id="delivery-address"]') do
              #fill_in('Street', :with => '12 Main Street')
            #end

        ##all

          # http://rubydoc.info/github/jnicklas/capybara/master/Capybara/Node/Finders#all-instance_method

          # Most general find method. All others are convenience on top of this.

          # Returns Capyabara::Result, whch is an Enumerable containing [Elements](http://rubydoc.info/github/jnicklas/capybara/master/Capybara/Node/Element)

          # By CSS

            #page.find(:xpath, '//div[contains(., "bar")]')
            #page.find(:css, '#foo.class')

          # Options:

          # - text(Bool). Containe text // match regexp. Possible in native xpath, but not CSS3.
          # - visible(Bool). Not very portable.

        ##find

          # `all()[0] || raise`

        ##find_link

          # `find(:css, 'a', text: text)`

        ##find_by_id

          # `find(:css, "##{id}")

      ##element

        # Useful methods:
        #
        # - find: find inside element
        # - click: click on element
        # - double_click:
        # - hover:
        # - visible? Not all drivers support CSS, so the result may be inaccurate.

      ##has methods

        ##has_content

          # Ignores HTML tags. Can also consider visibility with extra options.

            assert page.has_content?("paragraph")
            assert(!page.has_content?("<p>"))

        ##has_xpath

          # Selects elements by xpath.

        ##has_css

          # Selects elements by css.

      ##xpath

        # Ok, quick xpath tutorial!

        ##vs css selectors

          # Advantages of xpath:
          #
          # - select by content.
          #
          #   Does not matter for Capybara because all CSS finder methods
          #   have the `text:` optoin which allows that.
          #
          # Advantages of CSS:
          #
          # - select by class without hacks
          # - much more widely known
          # - golfs better
          #
          # Therefore, for the time being, we are sticking to  CSS.

        ##/ is direct child, `//` is descendant:

          assert page.has_xpath?("//p[@id='xpath-p-id']//span")
          assert page.has_xpath?("//p[@id='xpath-p-id']//span[@class='b']")
          assert !page.has_xpath?("//p[@id='xpath-p-id']/span[@class='b']")

        # Double or single quotes are the same:

          assert page.has_xpath?("//p[@id='xpath-p-id']")
          assert page.has_xpath?('//p[@id="xpath-p-id"]')

        ##* is an element of any type:

          assert page.has_xpath?("//*[@id='xpath-p-id']")

        # Multiple predicates:

          assert page.has_xpath?("//div[@id='xpath-text' and text()='div']")

        ##@

          # #@ab='cd' for property `ab`
          # #@*='cd'  for any property = `cd`
          # #[@ab]    any element with the property `ab`

        ##text() for first inner non tag content:

          assert page.has_xpath?("//div[@id='xpath-text' and text()='div']")

        ##dot TODO what does the dot select? vs text()?

          #assert page.has_xpath?("//div[@id='xpath-text' and .='div<span>span</span>div2']")

        ##contains()

          assert page.has_xpath?("//div[@id='xpath-contains' and contains(text(), 'bcd')]")

        ##class

          # There does not seem to be a convenient method to select CSS classes via XPATH: http://stackoverflow.com/questions/1390568/how-to-match-attributes-that-contain-a-certain-string

          # The best option seems to be:

            #//*[contains(concat(' ', normalize-space(@class), ' '), ' atag ')]

      # Title head element:

        assert page.title =~ /^\s*capybara title/

      # The raw body:

        #puts "page.body = " + page.body

    ##click_link

      # `find().click`

        click_link('a-id')
        assert current_path = '/'
        visit path

    ##popup dialog

      # Mark Cucumber Scenario with @javascript and:

        #page.driver.browser.switch_to.alert.accept
        #page.driver.browser.switch_to.alert.dismiss
        #page.driver.browser.switch_to.alert.text

    # Save current page to a temporary file and open it in default browser.
    # Good way to debuge failing tests.

      #save_and_open_page
  end
end
