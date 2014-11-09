# Demonstration of Factory Girl Rails integration.

FactoryGirl.define do
  # Uses model0 class because of the factory name.
  factory :model0 do
    string_col "s1"
    integer_col 1
  end

  # This will use the Model1 class (Model1Factory would have been guessed).
  factory :model1_factory, class: Model1 do
    string_col "s1"
    integer_col 1
  end

  sequence(:integer_col) { |n| n }
  factory :model0_sequence, class: Model0 do
    # Inline lazy
    sequence(:string_col) { |n| "s#{n}" }
    # Sequence with the same name as the attribute.
    integer_col
    # Explicit generation with generate.
    integer_col2 { generate(:integer_col) }
  end
end
