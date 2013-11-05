#ubuntu install

Install Rails on Ubuntu with RVM:
<https://www.digitalocean.com/community/articles/how-to-install-ruby-on-rails-on-ubuntu-12-04-lts-precise-pangolin-with-rvm>

Should work for most other Linux distros as well.

The line which has been put on `~/.bash_profile` should be moved to `~/.bashrc`.

Will also need nodejs:

    sudo aptitude install nodejs

#rails command

Create a new project template:

    rails new project-name

Run test server:

    cd project-name
    rails server

Shortcut:

    rails s

By default this serves on port `3000`.

Generate a controller template with one action:

    rails generate controller controller-name action-name

Shortcut:

    rails g controller controller-name action-name

Delete files created with generate:

    rails destroy controller controller-name

Shortcut:

    rails d controller controller-name

#controller

Controllers take user inputs (HTTP requests) and return the expected data page.

Controllers are classes. They live under `app/controller`.

#action

Actions are controller methods.

Each URL maps to an action which takes care of it.

The view for an action named `action0` (the name of the method)
of the controller class named Controller0
automatically corresponds to the `erb` file `app/views/controller0/action0.html.erb`.

Any instance variable defined in the function as `@var0`
becomes available to its corresponding `erb` as `@var0`.

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

Models live under `app/models`.

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

##migration

Migrations are specifications of how databases should change.

Migrations have two components:

- ruby classes derived from `ActiveRecord::Migration` in files under `db/migrate`
    which describe in ruby how the migration should happen

- database information which stores migration metadata.

Migration templates can be generated with:

    rails generate migration MigrationName

Certain migration names are special and lead to better template creation.

For example, any name of the form `Add<column_name>To<table_name>` already
adds a table addition to the generated template. Example:

    rails generate migration AddColumnNameToTableName column_name:string

will create a migration template that adds
a string column named `column_name` to table TableName.

List all migrations, including where we currently are:

    rake db:status

Apply all migrations up to the most recent:

    rake db:migrate

Go back to last migration:

    rake db:rollback
