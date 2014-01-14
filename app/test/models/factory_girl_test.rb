# Main cheat on factory usage.

require 'test_helper'

class FactoryGirlTest < ActiveSupport::TestCase
  def setup
    # Get rid of fixture data.
    DatabaseCleaner.clean_with(:truncation, only: [:model0s, :model1s])
  end

  test "create" do
    model0 = create(:model0)
    assert model0.string_col == 's1'
    assert model0.integer_col == 1
    assert Model0.find_by(integer_col: 1).string_col == 's1'

    # It is possible to set customize any of the parameters at creation time.
    model0 = create(:model0, integer_col: 2)
    assert model0.string_col == 's1'
    assert model0.integer_col == 2
  end

  test "sequence" do
    model0 = create(:model0_sequence)
    assert model0.string_col == 's1'
    assert model0.integer_col == 1
    assert model0.integer_col2 == 2

    model0 = create(:model0_sequence)
    assert model0.string_col == 's2'
    assert model0.integer_col == 3
    assert model0.integer_col2 == 4
  end
end
