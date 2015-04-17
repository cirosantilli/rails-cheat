# Directory structure

-   `app`: most of the app
-   `vendor`: third party things.
    - `bundle`: Ruby gems
    - `assets`: Third party Javascripts and Style sheets.

Places to put JavaScript:

- `app/assets/javascripts`:    JavaScript you create for your application.
- `lib/assets/javascripts`:    scripts that are shared by many applications (but use a gem if you can).
- `vendor/assets/javascripts`: copies of JQuery plugins, etc., from other developers.

## config

-   `application.rb` and environments under `environments`.

    Basic configuration of Rails built-in things.

-   `config/initializers`:

    Configurations of things which are not built-in rails, such as installed gems.

### config/initializers

Are automatically required on many files of the application including:

- views
- controllers.

Is not automatically required for:

- config files

Initializers are not put on the require path.

## lib

Is put on the Ruby require path.

Does not work for config files.

### lib/tasks

All `.rake` files in this dir are searched for rake commands.

## public

Contains files that will be served directly by the server, such as images.

Consider using the asset pipeline for uncompressed JavaScript and CSS files to reduce their size. Asset pipeline files are put under `app/assets`, and when on production the compressed version is put under `public/assets`.

The URL for a file under `public` such as `public/images/png.png` will be `images/png.png`.

It is also possible to serve files with `send_file` and `send_data`. This method first passes the file through Rails, so it is slower than serving directly from `/public`. However, in certain cases it is the best option:

- you must control who can download the files. Not possible for files under `/public`, which are all readable by anyone.
- you generate the data on the fly.
