require 'test_helper'

# The following hierarchy exists:
#
#     ActionController::TestCase < ActiveSupport::TestCase <  MiniTest::Unit::TestCase 
#
# Where `MiniTest::Unit::TestCase` is the Minitest present in the Ruby stdlib:
# http://ruby-doc.org/stdlib-2.1.0/libdoc/minitest/rdoc/MiniTest.html
#
# It is the `ActionController::TestCase` that adds stuff like:
#
# - `get`, `post`, etc.
# - request, response
# - the four hashes: assigns, cookies, flash, session
#
class Controller0ControllerTest < ActionController::TestCase

  # Must include this for devise tests, or simple things like `get` may not work.
  include Devise::TestHelpers

  def test_fixtures_were_loaded
    # This checks that fixtures were actualy loaded.
    assert_equal(Model0.find_by(string_col: 's1').integer_col, 1)
    refute_equal(Model1.find_by(string_col: 't1'), nil)
    # Rows can be named on the fixtures and accessed here as:
    assert_equal model0s(:model0_1).integer_col, 1
  end

  # DB is reset to fixtures between each test function.

    def test_destroy
      Model0.destroy_all
      assert_equal(Model0.find_by(string_col: 's1'), nil)
    end

    def test_after_destroy
      assert_equal(Model0.find_by(string_col: 's1').integer_col, 1)
    end

  # This test uses methods furnished by `ActionController::TestCase`
  #
  def test_action_controller_test_case_specifiK

    ##get

      # Makes a get request.

      # Assertions are made directly on the response obejct.

      # Controller is deduced from current classname / filename.

        get :action0
        get :action1
        get :haml
        #get(:action0, {'id' => '12'}, {'user_id' => 5})
        #get(:view, {'id' => '12'}, nil, {'message' => 'booya!'})

    ##Available variables

      # http://api.rubyonrails.org/classes/ActionController/TestCase.html

      # The follwoing variables are available:

        @controller

      # Contains the previous request made.
      # If modified will affect the next request.

        @request

      ##response

        # Contains previous response:

          get :action0
          assert_equal @response.status, 200
          assert_equal response.status, 200

        # TODO @response vs response. Current guide examples use only `@response`.

      ##assigns

        # Hash with the value given to `@var0` passed to last rendered template.

          get :action0
          assert_equal assigns(:var0), 0

          get :action1
          assert_equal assigns(:var0), 1

        # Would be a Hash, but for historical reasons the Hash `assigns['asdf']`,
        # only takes strings, so the method with symbols is used instead.

    ##assertions

      # The following assertions are added by Rails for convenience.
      # They could all be achieved with Minitest assertions + request / response objects.

      ##assert_response

        # Assert status of last response. Most symbols are integer ranges.
        # http://api.rubyonrails.org/classes/ActionDispatch/Assertions/ResponseAssertions.html#method-i-assert_response

          get :action0
          assert_response :success

          get :action0
          assert_response 200

          get :redirect_to_action0
          assert_response :redirect

      ##assert_redirected_to

        # Assert that latest response redirect to somewhere.
        # http://api.rubyonrails.org/classes/ActionDispatch/Assertions/ResponseAssertions.html#method-i-assert_redirected_to

        # Query strings must match.

          get :redirect_to_action0
          assert_redirected_to controller: :controller0, action: :action0,
              notice: 'notice redirect', alert:  'alert redirect'

      ##assert_template

        # Assert that a given template was rendered.

          get :action0
          assert_template :action0
          assert_template layout: 'layouts/application'

      ##assert_select

        # http://api.rubyonrails.org/classes/ActionDispatch/Assertions/SelectorAssertions.html#method-i-assert_select

        # Asserts that the response matches a CSS selector or other selector types.
        # Can also assert the content of the selected element.

          get :view_tests
          assert_select('#assert-select .inside-select', 'content')

      ##assert_routing

        # Assert what the input string URLs will redirect to.
        # Used to test routes.

          assert_routing '/', {controller: 'controller0', action: 'action0', locale: 'en'}
          assert_routing '/controller0/model0s/1', {controller: 'controller0', action: 'show', id: '1', locale: 'en'}
  end

  ##devise

    # Devise offers the following test helpers:

    # sign_in :user, @user   # sign_in(scope, resource)
    # sign_in @user          # sign_in(resource)
    # sign_out :user         # sign_out(scope)
    # sign_out @user         # sign_out(resource)

  ## View tests

    # The following tests are for things which are shown in the views.

      ##ERB

      ##Erubis

      def test_erb
        get(:action0)
        assert_select('#erb-equal-newline'                  , "a\nb")
        assert_select('#erb-equal-newline-hyphen'           , 'ab'  )
        assert_select('#erb-equal-newline-hyphen-spaces'    , 'ab'  )
        assert_select('#erb-hyphen-newline'                 , "a\nb"  )
        assert_select('#erb-newline-hyphen-leading'         , "a\nb")
        assert_select('#erb-blank-line-hyphen-leading'      , "a\n\nb")
        assert_select('#erb-blank-line-space-hyphen-leading', "a\n\n b")
        assert_select('#erb-newline-hyphen-leading-trailing', "a\nb")
      end

      def test_partials
        get(:action0)
        assert_select('#partial-instance', '0')
        assert_select('#partial-optional-local', '0')
      end
end
