# This is the main cheat for tests.

require 'test_helper'

# The following hierarchy exists in Rails 4:
#
#     ActionController::TestCase < ActiveSupport::TestCase <  MiniTest::Unit::TestCase 
#
# Where `MiniTest::Unit::TestCase` is in the stdlib.
#
class Controller0ControllerTest < ActionController::TestCase

  # Must include this for devise tests, or simple things like `get` may not work.
  include Devise::TestHelpers

  # Every method that starts with `test` is run as a test.
  #
  # The `test` method creates such methods.
  # It replaces spaces by underlines.
  #
  def test_name_of_test
  end

  test "assert example" do
    assert true
    assert_equal(0, 0)
    assert_raises(RuntimeError){ raise }
  end

  test "fixtures were loaded" do
    assert Model0.find_by(string_col: 'a0').integer_col == 0
  end

  test "fixtures for other tests were also loaded" do
    assert Model0.find_by(string_col: 'a0') != nil
  end

  test "retreive fixture named rows" do
    assert model0s(:model0_0).integer_col == 0
  end

  # DB is reset to fixtures between each test function.

    test "destroy" do
      Model0.find_by(string_col: 'a0').destroy
      assert Model0.find_by(string_col: 'a0') == nil
    end

    test "after destroy" do
      assert Model0.find_by(string_col: 'a0') != nil
    end

  # This test uses methods furnished by `ActionController::TestCase`
  #
  test "ActionController TestCase specific" do

    ##get

      # Makes a get request. Assertions are made directly on the response obejct.

      # Controller is deduced from classname / filename.

        get :action0
        #get(:action0, {'id' => "12"}, {'user_id' => 5})
        #get(:view, {'id' => '12'}, nil, {'message' => 'booya!'})

    ##assert_response

        assert_response :success

    ##assigns

      # Returns the value given to `@var0` passed to the template.

        assert_equal(assigns(:var0), 0)

    assert_routing '/', {controller: "controller0", action: "action0"}
    assert_routing 'controller0/model0/1', {controller: "controller0", action: "show", id: "1"}


    # The follwoing variables are available:

        @controller

    # Request can be modified before requests are made, and affects the following requests.

        @request

    # Request is modified by requests to contain the previous resonse.

        @response

        assert_template :action0
        assert_template layout: "layouts/application"
  end

  ##setup and ##teardown

      # This method is run before each test method.
      #
      def setup
        @a = 1
      end

      # This method is run after each test method.
      #
      def teardown
        @a = 0
      end

      test "setup" do
        assert_equal @a, 1
      end

  ##devise

    # Devise offers the following test helpers:

    # sign_in :user, @user   # sign_in(scope, resource)
    # sign_in @user          # sign_in(resource)
    # sign_out :user         # sign_out(scope)
    # sign_out @user         # sign_out(resource)

end
