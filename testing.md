# Testing

The default testing library is `minitest`, which was introduced in the Ruby 1.9 stdlib.

It is a gem requisite of the `activesupport` gem. `ActiveSupport::TestCase` extends the standard `Test::Unit::TestCase`.

There are also rails classes which inherit from `ActiveSupport::TestCase` and offer more test methods, such as `ActionController::TestCase` which offers useful methods like `get` and `assert_routing`.

Load test data on the test DB.

Create the test DB from the current `db/schema.rb`:

    bundle exec rake db:test:load

Run all the tests:

    bundle exec rake test

Run one type of tests under `tests/XXX/`:

    bundle exec rake test:controllers
    bundle exec rake test:models
    bundle exec rake test:integration

There is also `test:units` which runs: `test/models`, `test/helpers`, and `test/unit`.

A good place to test `lib/` code is `test/unit`: <http://stackoverflow.com/questions/798881/rails-how-to-test-code-in-the-lib-directory> This is run by default on `rake test` and `rake units`.

Run a single test function from a test file: <http://stackoverflow.com/questions/274349/running-single-rails-unit-functional-test>

    bundle exec rake test tests/models/model0.rb test_name_of_the_test

Where `name_of_the_test` is the test name with spaces replaced by underlines.

Run all tests matching a given regexp in given file:

    bundle exec ruby -I"lib:test" test/unit/invitation_test.rb -n /.*between.*/
