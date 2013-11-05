require 'test_helper'

class Controller0ControllerTest < ActionController::TestCase
  test "should get action0" do
    get :action0
    assert_response :success
  end

  test "should get action1" do
    get :action1
    assert_response :success
  end

end
