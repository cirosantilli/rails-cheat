# Database

Database connection is configured at the file `config/database.yml` which is a YAML file.

- `adapter`: database type. Most common values: `sqlite3` (default), `mysql` and `postgresql`
- `username`: if not present, Rails tries to use the current username to log into the database.

## Default databases

By convention RoR application development uses 3 databases:

-   `development`: used for runnings app tests manually on a browser.

    This database is used by default when using `rails serve`.

-   `test`: used for unit tests. Erased every time a new unit test will be run via `rake test`.

-   `production`: the actual database that end users will see.

    To use this database with the rails some options follow.

    Command line argument (preferred if possible):

        rails serve -e production

    Environment variable:

        RAILS_ENV=production rails serve

    or:

        export RAILS_ENV=production
        rails serve

## create

Once the database connection is configured, create current database (`Rails.env`):

    rake db:create

This only creates an empty database without any tables.

Create all databases (e.g. development, test and production):

    rake db:create:all

Create only the production database:

    RAILS_ENV=production rake db:create

This does not automatically migrate.

Run each migration, modifying the database, including table creation:

    rake db:migrate

This will also implies `db:schema:dump`, which reads the database schema and stores it under `db/schema.rb`, updating that file.

Create tables on an existing DB using `db/schema.rb`:

    rake db:schema:load

This is useful after migrations have already been done and `db/schema.rb` is already up to date. In that case, this command can be much faster than a migration.

By default this recreates all tables destroying their data, since by default schemas have the `force: true` option at creation on migrations and on the schema.

Populate the database with its initial data for a new app installation:

    rake db:seed

This data is defined under `db/seed.rb`.

`db:load:schema` + `db:seed`:

    rake db:setup

This is a good option to start a database to its working condition
once migrations have already made `db/schema.rb` be up to date,
for example to reset a development database after a `db:drop`, or after cloning a project.

`db:drop` + `db:setup`:

    rake db:reset

Great to turn a development database to its initial state.

## dbconsole

Log into the REPL of the DBMS used by the current application:

    rails dbconsole

The database must exist.

Alias:

    rails db

## migration

Migrations are specifications of how databases should change.

Migrations have two components:

- ruby classes derived from `ActiveRecord::Migration` in files under `db/migrate` which describe in ruby how the migration should happen

- database information which stores migration metadata.

Migration templates can be generated with:

    rails generate migration MigrationName

Certain migration names are special and lead to better template creation. They are also more standard, so use them whenever possible.

For example, any name of the form `Add<column_name>To<table_name>` already adds a table addition to the generated template. Example:

    rails generate migration AddColumnNameToTableName column_name:string

will create a migration template that adds a string column named `column_name` to table `TableName`.

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

## fixture

Fixtures are data to be used in tests.

By default, the test DB is set to be exactly equal to the fixtures before every test function.

In rails 4 they are located under `test/fixtures/`.

As of 2014-01, it is only possible to define one single fixture data for all tests, not different data per test.

This can be done by not using any fixtures, and then creating data manually or with external plugins such as Factory Girl.

TODO: prevent fixture from loading for a single test?
