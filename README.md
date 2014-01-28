Information and cheats on Rails.

Live version of the application app at: <http://cirosantilli-rails-cheat.herokuapp.com/>

You can deploy your own instance instantly with:

    ./heroku-deploy.sh appname

Certain features of the app may break on that deployment such as file uploads due to the ephemeral FS.
This could be corrected by using something like FTP or AWS.

#location of the main cheats

Different cheats fit better into different places.

This lists some not necessarily obvious choices:

- `app/controller/controller0_controller.rb`: as many assertions as possible.

- `app/views/controller0/action0.html.erb`: shows on the browser unpredictable outputs,
    or outputs which are too large to assert on such as helpers.

- `test/controllers/controller0_controller_test.rb`: main tests cheat.

- `test/models/active_record_test.rb` contains cheats on active records.

    Those had to be moved to tests instead of controllers since the database
    state has to be controlled to run tests.

#ubuntu install

Install Rails on Ubuntu with Ruby RVM:
<https://www.digitalocean.com/community/articles/how-to-install-ruby-on-rails-on-ubuntu-12-04-lts-precise-pangolin-with-rvm>

Should work for most other Linux distros as well.

The line which has been put on `~/.bash_profile`
in the tutorial should be moved to `~/.bashrc` instead.

Will also need nodejs:

    sudo aptitude install nodejs

#config

- `application.rb` and environments under `environments`.

    Basic configuration of Rails built-in things.

- `config/initializers`:

    Configurations of things which are not built-in rails,
    such as installed gems.

#rails command

Create a new project template:

    rails new project-name

Use a specific RDMS

    rails new myapp --database=postgresql

Run test server:

    cd project-name
    rails server

Shortcut:

    rails s

By default this serves on port `3000`.

Generate a controller template with one action:

    rails generate controller controller-name action-name

Shortcut:

    rails g controller controller-naue action-name

Delete files created with generate:

    rails destroy controller controller-name

Shortcut:

    rails d controller controller-name

#rake

`rake` is the standard way to create new commands to be used interactively.

To create a new rake task add a `.rake` file with any name under `lib/tasks` in Rakefile format.

Useful tasks which did not fit anywhere else:

- `tmp:clear` and `log:clear`. May greatly reduce directory sizes.

#controller

Controllers take user inputs (HTTP requests) and return the expected data page.

Controllers are classes. They live under `app/controller`.

Generate a controller template:

    rails generate controller Controller0

Also generates tests, assets, helpers.

Generate a controller inside a namespace:

    rails generate controller Namespace0::Controller0
    rails generate controller namespace0/controller0

#action

Actions are controller methods.

Each URL maps to an action which takes care of it.

The view for an action named `action0` (the name of the method)
of the controller class named Controller0
automatically corresponds to the `erb` file `app/views/controller0/action0.html.erb`.

Any instance variable defined in the function as `@var0`
becomes available to its corresponding `erb` as `@var0`.

#helper

Helpers are usually method that output HTML and which are used in views.

They should be defined under `app/helpers`.

#routes

Determine which action to take for each URL.

Config file: `app/config/routes.rb`

To view all the routes, run:

    rake routes

#model

See active records.

#active records

Name for the RoR provided ORM.

A model is a class that will map to a database table.
Models inherit from `ActiveRecord::Base`.

Models are defined by:

- `db/schema.rb`: defines the columns and DBMS properties of the database.
    This file is automatically generated by the migrations, so don't modify it.

- `app/models`: can define properties of models that are not database implemented
    such as Ruby implemented validation.

Create a new model template:

    rails generate model model_name

or

    rails generate model ModelName

In both cases above the class will by default be named `ModelName`
and the table `model_name`.

This will also create a db migration and test fixtures templates.

Create a template with some fields:

    rails generate model model_name column0:string column1:string

#database

Database connection is configured at the file `config/database.yml`
which is a YAML file.

- `adapter`: database type. Most common values: `sqlite3` (default), `mysql` and `postgresql`
- `username`: if not present, Rails tries to use the current username to log into the database.

##databases

By convention RoR application development uses 3 databases:

- `development`. Used for runnings app tests manually on a browser.

    This database is used by default when using `rails serve`.

- `test`. Used for unit tests. Erased every time a new unit test will be run via `rake test`.

- `production`. The actual database that end users will see.

    To use this database with the rails some options follow.

    Command line argument (preferred if possible):

        rails serve -e production

    Environment variable:

        RAILS_ENV=production rails serve

    or:

        export RAILS_ENV=production
        rails serve

##create

Once the database connection is configured, create current database (`Rails.env`):

    rake db:create

This only creates an empty database without any tables.

Create all databases (e.g. development, test and produciton):

    rake db:create:all

Create only the production database:

    RAILS_ENV=production rake db:create

This does not automatically migrate.

Run each migration, modifying the database, including table creation:

    rake db:migrate

This will also implies `db:schema:dump`, which reads the database schema
and stores it under `db/schema.rb`, updating that file.

Create tables on an existing db using `db/schema.rb`:

    rake db:schema:load

This is useful after migrations have already been done and `db/schema.rb`
is already up to date. In that case, this command can be much faster than
a migration.

By default this recreates all tables destroying their data, since by default
schemas have the `force: true` option at creation on migrations and on the schema.

Populate the database with its initial data for a new app installation:

    rake db:seed

This data is defined under `db/seed.rb`.

`db:load:schema` + `db:seed`:

    rake db:setup

This is a good option to start a database to its working condition once
migrations have already made `db/schema.rb` be up to date, for example
to reset a development database after a `db:drop`, or after cloning a project.

`db:drop` + `db:setup`:

    rake db:reset

Great to turn a development database to its initial state.

##dbconsole

Log into the REPL of the RDMS used by the current application:

    rails dbconsole

The database must exist.

Alias:

    rails db

##migration

Migrations are specifications of how databases should change.

Migrations have two components:

- ruby classes derived from `ActiveRecord::Migration` in files under `db/migrate`
    which describe in ruby how the migration should happen

- database information which stores migration metadata.

Migration templates can be generated with:

    rails generate migration MigrationName

Certain migration names are special and lead to better template creation.
They are also more standard, so use them whenever possible.

For example, any name of the form `Add<column_name>To<table_name>` already
adds a table addition to the generated template. Example:

    rails generate migration AddColumnNameToTableName column_name:string

will create a migration template that adds
a string column named `column_name` to table TableName.

Other standard migration generate include:

Remove column from table:

    rails generate migration RemovePartNumberFromProducts part_number:string

Create a new table:

    rails generate migration CreateProducts name:string part_number:string

You will probably want to leave this to a `generate model` command.

List all migrations, indicating which ones have been applied or not:

    rake db:status

Get the current migration timestamp:

    rake db:version

Apply all migrations up to the most recent:

    rake db:migrate

Go back to last migration:

    rake db:rollback

##fixture

Fixtures are data to be used in tests.

By default, the test db is set to be exactly equal to the fixtures before every test function.

In rails 4 they are located under `test/fixtures/`.

As of Jan 2014, it is only possible to define one single fixture data for all tests,
not different data per test.

This can be done by not using any fixtures, and then creating data manually or
with external plugins such as Factory Girl.

TODO: prevent fixture from loading for a single test?

#concerns

Located under `app/models/concerns`.

Files contain modules which extend from `ActiveSupport::Concern`.

Used for code that is strongly coupled to models, but should be shared amongst models.

When to use concerns vs `lib`: <http://stackoverflow.com/questions/16159021/rails-service-objects-vs-lib-classes>

#scaffold

Automatically generates a base CRUD interface for a model.

    rails generate scaffold ModelName

#tests

The default testing library is `minitest`, which was introduced in the Ruby 1.9 stdlib.
It is a gem requisite of the activesupport gem.
`ActiveSupport::TestCase` extends the standard `Test::Unit::TestCase`.
There are also rails classes which inherit from `ActiveSupport::TestCase` and offer more
test methods, such as `ActionController::TestCase` which offers useful methods like `get`
and `assert_routing`.

Load test data on the test db.

Create the test db from the current `db/schema.rb`:

    rake db:test:load

Run all the tests:

    rake test

Run only controller ony type of tests under `tests/XXX/`

    rake test:controllers
    rake test:models
    rake test:integration

Run the only tests on `tests/models/model0_test.rb` do either of:

    rake test model0
    rake test tests/models/model0
    rake test tests/models/model0.rb

Run a single test function from a test file:

    rake test tests/models/model0.rb test_name_of_the_test

Where `name_of_the_test` is the test name with spaces replaced by underlines.

Run all unit tests:

    rake test:units

Run all functional tests:

    rake test:functionals

Run all integration tests:

    rake test:integration

Run all tests matching a given regexp in given file:

    ruby -I"lib:test" test/unit/invitation_test.rb -n /.*between.*/

##mail

##email

##action mailer

Quickstart:

    rails generate mailer MyMailer

Generates:

    app/mailers/my_mailer.rb
    app/views/my_mailer/
    test/mailers/my_mailer_test.rb

SMPT configuration under `config/initializers/smtp_settings.rb`:

    App::Application.config.action_mailer.delivery_method = :smtp
    ActionMailer::Base.smtp_settings = {
      address:              'smtp.gmail.com',
      port:                 587,
      domain:               'gmail.com',
      user_name:            'user@gmail.com',
      password:             'pass',
      authentication:       'plain',
      enable_starttls_auto: true
    }

Create a `.example` version and Gitignore it to protect the password.

#lib

Is put on the Ruby require path.

Does not work for config files.

##lib/tasks

All `.rake` files in this dir are searched for rake commands.

#initializers

Are automatically required on many files of the application including:

- views
- controllers.

Is not automatically required for:

- config files

Initializers are not put on the require path.

#public

Contains files that will be served directly by the server, such as images.

Consider using the assets system for uncompressed javascript and css files to reduce their size.

The url for a file under `public` such as `public/images/png.png` will be `images/png.png`.

#assets

The assets pipeline allows to:

- preprocess files once before letting them being served statically

    - erb -> HTML, SCSS -> CSS, etc. conversions, so you can write your assets in more convenient languages.

    - removal of extra spaces from javascript and CSS to reduce their size

    - concatenation of multiple CSS and Javascript files into a single file
        so that they load faster.

- improve browser caching by adding MD5 hashes to filenames:
    <http://stackoverflow.com/questions/10952876/why-should-i-use-the-asset-pipeline-to-serve-images>

    This seems to be the main reason to serve files like images via the assets pipeline even if they
    don't need to be preprocessed.

Assets are located under `app/assets`.

In development mode, assets are used directly from the `app/assets` directory
and compiled every time to ease debugging the application.

##gitignore

`public/assets` is not present on the default `.gitignore` because:

- it is sometimes necessary to precompile locally and `git add` to deploy to servers like Heroku
- `public/assets` should not exist in the first place in a development environment,
    in which one should never run `rake assets:precompile`.

##production

In production mode, all assets should be compiled only once before the app is started,
and served from `/public/assets/`.
Files are taken from from under `/app/assets`, processed, and put under `/public`.

By default, you must manually compile the assets before serving them with
`RAILS_ENV=production bundle exec rake assets:precompile`.
Do not forget the `RAILS_ENV` or for example debug mode may be on and
the assets will not be compressed or concatenated.

By default Rails does not serve files under `public` in production mode as this
job should be left fot the a webserver such as Apache or NGinx for efficiency reasons.
If you really want Rails to serve those files edit `config.serve_static_assets = true` under
`config/environment/production.rb`.

#third party testing libraries

Besides the built-in test classes, there tons of third party test libraries,
many of which mix with one another.

##rspec

General unit test framework. Alternative to Minitest (default Rails 4).

Not rails / web framework specific.

TODO vs Minitest (rails 4 default)? Minitest interface saner and is default.

Install `Gemfile`:

    group :development, :test do
        gem 'rspec-rails'
    end

Generate templates `.rspec` and `spec/spec_helper.rb`.:

    rails generate rspec:install

Tests are located under `/spec/`.

Tests are run with:

    rake spec

It may be possible to run them with:

    cd RAILS_ROOT
    rspec

but his may have disadvantages: `rake spec` may do more initialization such as DB TODO confirm.

The rspec version may start running faster.

Only run tests from a single file (<http://stackoverflow.com/questions/6116668/rspec-how-to-run-a-single-test>):

    bundle exec rake spec SPEC=path/to/spec.rb

or

    bundle exec rspec path/to/spec.rb

Only run a test that includes a string

    bundle exec rake spec SPEC=path/to/spec.rb SPEC_OPTS="-e \"should be successful and return 3 items\""

##spinach

Unit testing framework, with yet another super mini language
(the Gherkin language, not a ruby DSL).
It seems that the goal of that language is to make tests accessible to people
who do not understand Ruby...

Tests are located under `/features/`.

General config file is `/features/support/env.rb`.

Tests are defined on `.feature` files writen in Gherkin located TODO where.

Step definition (what each part of a feature test does) goes under `steps`

Generate basic spinach files:

    rails generate spinach

Run all the tests:

    RAILS_ENV=test bundle exec rake spinach

Or:

    bundle exec rake spinach

Run only tests on given file:

    bundle exec rake spinach features/path/to/file.feature

##cucumber

Similar to Spinach, and came before it.

Also uses the Gherkin language.

##capybara

Offers methods to interact with the application through a browser automation
(by default via Selenium), such as:

- `visit`: go to a page
- `page.has_text`: finding visible text on the screen (not a direct `body` element search)
- clicking on a button or link
- filling a form

Those are useful to test the application from the user point of view.

Can be used with any Unit test framework such as Minitest or RSpec.

Recommended location for tests are: `test/integration` for Minitest (built-in) tests
and `spec/features` for RSpec tests.

Good cheatsheet: <https://gist.github.com/zhengjia/428105>

LIke other integration tests, capybara tests can be run with `rake test:integration`,
which is called by `rake test`.

##factory girl

Interface to generates test data.

The default fixtures method is bad because it is not possible to have per test
data with it.

TODO Advantage over manually using create?

Factories are automatically loaded from `(spec|test)/(factories.rb|factories*.rb)`.

If included, may be the source of the following methods in the tests:

    # Returns a User instance that's not saved
    user = build(:user)

    # Returns a saved User instance
    user = create(:user)

    # Returns a hash of attributes that can be used to build a User instance
    attrs = attributes_for(:user)

    # Returns an object with all defined attributes stubbed out
    stub = build_stubbed(:user)

    # Passing a block to any of the methods above will yield the return object
    create(:user) do |user|
    user.posts.create(attributes_for(:post))
    end

#guard

Monitors the filesystem for file modifications, and when those happen run certain commands.

Major application: automatically run tests when test files are modified.

To do that, install directly plugin gems which support your types of tests:

- `gem guard-test`
- `gem guard-rspec`
- `gem guard-spinach`

##guard test

Install:

    gem guart-test

Then run:

    bundle install
    guart init test

Start running:

    bundle exec guard

Now just leave guard running and it will redo tests whenever the files are mofidifed.

Guard produces notifications to its stdout and to the desktop notification system.

#devise

User signup and authentication.

Gemfile: `gem devise`.

    rails generate devise:install
    rails generate devise:views
    rails generate devise User

where `User` is the model that will represent the user.

##email confirmation

Get action mailer working.

`app/models`: uncomment `:confirmable`

Migration file: uncomment the `:confirmable` section.

`config/initializers/devise.rb`:

- config.mailer = 'Devise::Mailer'

##unregistered users

Just don't add:

    before_filter: authenticate!

and unauthenticated users can view pages normally.

---

rake db:migrate

Restart rails.

##omniauth

#foreman

Tool that starts many processes at once, for example one main web process + many works.

Advantages over a plain script:

- one C-C and SIGTERM is sent to all the processes invoked

Files:

- `Procfile`: main configuration file.

    Bash variable notation like `$PORT` does not imply that the value will be taken from 

- `.env` and `.procfile`: from those files it is possible to set the bashlike variables of `Procfile`.

    TODO what is the difference between them?

    `.procfile` is YAML:

        port: 3001

    `.env` is yet another magic format:

        PORT=3001

#settings logic

Settings manager gem.

Files:

- config/settingslogic.yml
- config/initializers/01_settingslogic.rb