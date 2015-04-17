# Spinach

Generate basic spinach files:

    rails generate spinach

Run all the tests:

    RAILS_ENV=test bundle exec rake spinach

Or:

    bundle exec rake spinach

Run only tests on given file:

    bundle exec rake spinach features/path/to/file.feature

Run only tests on given file at given line:

    bundle exec rake spinach features/path/to/file.feature:15
