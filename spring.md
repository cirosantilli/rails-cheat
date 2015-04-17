# Spring

Application pre-loader. No relation to the [Spring Framework](https://github.com/spring-projects/spring-framework) :)

Loading a large Ruby application can take a lot of time, and has to be done every time before an individual test.

Spring pre-loads the application, leading to much shorter waits.

Installed in the default Rails 4.1 template.

<https://github.com/rails/spring>

Usage: first either of:

    bundle exec spring rake test
    bundle exec spring rspec spec/some_test.rb

This will automatically start running Spring on the background. The second time, the command can be much faster:

    bundle exec spring rake test
    bundle exec spring rspec spec/some_test.rb

To check if spring is running do:

    bundle exec spring status

To stop it:

    bundle exec spring stop

If you add a new gem, make sure to restart the Spring server or it might not find it.
