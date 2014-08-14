require 'test_helper'

# Main Capybara cheatsheet.

##sources

  # The README is a great source of info: <https://github.com/jnicklas/capybara>

  # Some of the doc pages contain useful info: <http://rubydoc.info/github/jnicklas/capybara/master/Capybara>

class CapybaraTest < ActionDispatch::IntegrationTest
  test "main" do
    path = "/capybara"
    visit path

    ##driver

      # Capybara is an unified interface to multiple drivers, which actually implement the functions.

      # Not all drivers support all functions. When this is the case, Capybara docs specify it.

      # Driver can be set under `support/env.rb`

        #Capybara.javascript_driver = :poltergeist

      # On Cucumber, drivers can be set per test with tags such as `@javascript`,
      # which uses the default Javascript enabled driver given by the `Capybara.javascript_driver` option.
      # There are also explicit `@selenium` and `@rack_test` tags.

      # Check this <https://github.com/jnicklas/capybara#drivers> for a list of drivers.

      ##RackTest

        # Capybara's default driver. Simple, limited and fast.
        #
        # - only works with Rack apps like Rails or Sinatra,
        # - and cannot access remote URLs.
        # - only considers HTML, not CSS and Javascript. Parses HTML with Nogokiri.

    ##visit

      # Go to an URL.

    ##current_url

      # Current URL, with method and host.

        #puts "current_url = " + current_url

    ##current_path

      # Only the current `path`, e.g. `/a/b/c?d=f`.

    ##page

      ##querying

        # http://rubydoc.info/github/jnicklas/capybara/master/Capybara/Node/Finders#all-instance_method

        ##all

          # http://rubydoc.info/github/jnicklas/capybara/master/Capybara/Node/Finders#all-instance_method

          # Most general find method. All others are convenience on top of this.

          # Returns Capyabara::Result, which is an Enumerable containing [Elements](http://rubydoc.info/github/jnicklas/capybara/master/Capybara/Node/Element)

          # If given, the first argument specifyies the query type:

            #page.find(:xpath, '//div[contains(., "bar")]')
            #page.find(:css, '#foo.class')

          # If not, uses an option which defaults to `:css`. So always specify.
          # to prevent breaks.

            #page.find(:css, '#foo.class')

          # Options:

          ##text

            # Restricts matches to elements that contain string if string given,
            # or that match regexp if regexp given.

            # Possible in native xpath, but not CSS3, and this options makes up for it.

              assert page.all(:css, '#all-text', text: 'a' ).present?
              assert page.all(:css, '#all-text', text: 'ab').present?
              assert page.all(:css, '#all-text', text: 'ef').present?

            # Does not see HTML tags, but does see text inside inner elements.

              assert page.all(:css, '#all-text', text: 'ab<i>cd</i>ef').blank?
              assert page.all(:css, '#all-text', text: 'cd').present?

            # There is not driver portable way of doing that:
            # http://stackoverflow.com/questions/15981820/capybara-should-have-html-content
            # The best driver dependent method seems to be `evaluate_script`.

            # Text node elements separated by HTML tags are seen as contiguous.

              assert page.all(:css, '#all-text', text: 'abcdef').present?
              assert page.all(:css, '#all-text', text: 'abef').blank?

            # The start and end of regexp matches corresponds to the cncatented string:

              assert page.all(:css, '#all-text', text: /^a/).present?
              assert page.all(:css, '#all-text', text: /^b/).blank?
              assert page.all(:css, '#all-text', text: /^e/).blank?

            # Trailing and heading whitespaces are removed:

              assert page.all(:css, '#all-text-whitespace', text: /^a$/).present?
              assert page.all(:css, '#all-text-whitespace', text: / a /).blank?

          # - visible(Bool). Not very portable. If true, only visible.
          #
          #    If false, **both** visible and invisible
          #
          #    Invisible means: TODO visible:false? display:none?
          #    Seems to depend on Driver: on RackTest only uses `display:none` set on parent node.
          #
          #    Default: false.

        ##find

          # `all()[0]`. Raise if none or multiple matches.

        ##find_link

          # `find(:css, 'a', text: text)`

        ##find_by_id

          # `find(:css, "##{id}")

        ##within

          # Limits scope of search to matching elements.

          # Useful to do multiple actions inside one scope.

            #within(:xpath, '//div[@id="delivery-address"]') do
              #fill_in('Street', :with => '12 Main Street')
            #end

          # For single inner searches, use multiple finds instead:

            #find(:css, '#id').find(:css, '.class')

      ##Element ##Result

        # Capybara::Node::Element, Capybara::Result
        #
        # capybara's representation of HTML elements, used by all of Capybara's methods,
        # returned inside the enumerable Capybara::Result for methods that return
        # collections of elements.
        #
        # http://rubydoc.info/github/jnicklas/capybara/master/Capybara/Node/Element
        #
        # Useful methods:
        #
        # - find: find inside element
        # - []: get value of attribute
        # - click: click on element
        # - set: set the text of input fields like `input` or `textarea`
        # - double_click:
        # - hover:
        # - visible? Not all drivers support CSS, so the result may be inaccurate.

      ##has methods

        ##has_content

          # Ignores HTML tags. Can also consider visibility with extra options.

            assert page.has_content?("paragraph")
            assert(!page.has_content?("<p>"))

        ##has_selector

          # all(...).present?

        ##has_xpath

          # has_selector(:xpath, ...)

        ##has_css

          # has_selector(:css, ...)

      ##xpath

        # A standard to do queries in XML.

        # Has nothing specific to do with Capybara, but putting a small tutorial here.

        # Prefer CSS as more web developpers use it, is also sane and golfs better.

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

    ##actions

      # All methods here are convenience only. The sanest way to achieve all those effects is to find the element with find,
      # and then use an Element method.

      ##click_link

        # `find().click`

      ##fill_in

        # find by id, name or label text and .set()

    ##popup dialog

      # This feature is not portable.

      # Poltergeist: always confirms popups, not yet possible to dismiss:
      # <https://github.com/jonleighton/poltergeist/issues/80>

      # Selenium interface:

        #page.driver.browser.switch_to.alert.accept
        #page.driver.browser.switch_to.alert.dismiss
        #page.driver.browser.switch_to.alert.text

    ##save_and_open_page

      # Save current page to a temporary file and open it in default browser.

      # Good way to debuge failing tests.

        #save_and_open_page
  end
end
