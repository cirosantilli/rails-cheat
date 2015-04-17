# guard

TODO split non-Rails specifics out. Likely everything except the Rails + Guardfile example?

Monitors the filesystem for file modifications, and when those happen run certain commands.

Major application: automatically run tests when test files are modified.

To do that, install directly plug-in gems which support your types of tests:

- `gem guard-test`
- `gem guard-rspec`
- `gem guard-spinach`

## guard test

Install:

    gem guart-test

Then run:

    bundle install
    guart init test

Start running:

    bundle exec guard

Now just leave guard running and it will redo tests whenever the files are mofidifed.

Guard produces notifications to its stdout and to the desktop notification system.
