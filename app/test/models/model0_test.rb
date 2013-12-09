require 'test_helper'

class Model0Test < ActiveSupport::TestCase

  test "assert example" do
    assert true
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
end
