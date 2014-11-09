# This factory will be loaded because it is under `test/factories`.
FactoryGirl.define do
  factory :any_name, class: Model0 do
    string_col "s1"
    integer_col 1
  end
end
