# Assets

The assets pipeline allows to:

-   preprocess files once before letting them being served statically

    - ERB -> HTML, SCSS -> CSS, etc. conversions, so you can write your assets in more convenient languages.

    - JavaScript and CSS minification

    - concatenation of multiple CSS and JavaScript files into a single file so that they load faster.

-   improve browser caching by adding MD5 hashes to filenames: <http://stackoverflow.com/questions/10952876/why-should-i-use-the-asset-pipeline-to-serve-images>

    This seems to be the main reason to serve files like images via the assets pipeline even if they don't need to be preprocessed.

Assets are located under `app/assets`.

In development mode:

- assets are used directly from the `app/assets` directory and compiled every time to ease debugging the application.
- comments are also added to the compile sheets telling from which file and line they come, to allow you to debug them easily.

It is recommended to put controller specific assets into files named after the controller, e.g. `controller0.js.coffee` for `Controller0Controller`.

However, by default the `= reqire_tree` in `applicaion.js.coffee` will include every controller Js into every page, so don't rely on it for specificity.

## Assets in production

In production mode, all assets should be compiled only once before the app is started, and served from `/public/assets/`. Files are taken from from under `/app/assets`, processed, and put under `/public`.

By default, you must manually compile the assets before serving them with:

    RAILS_ENV=production bundle exec rake assets:precompile

Do not forget the `RAILS_ENV` or for example debug mode may be on and the assets will not be compressed or concatenated.

By default Rails does not serve files under `public` in production mode as this job should be left for a web server such as Apache or Nginx for efficiency reasons. If you really want Rails to serve those files edit `config.serve_static_assets = true` under `config/environment/production.rb`.

## Asset permission control

<http://guides.rubyonrails.org/asset_pipeline.html#x-sendfile-headers>

<http://stackoverflow.com/questions/2143300/protecting-the-content-of-public-in-a-rails-app>

Use `send_file`, which uses the `X-Sendfile` extension header.

## gitignore public assets

`public/assets` is not present on the default `.gitignore` because:

- it is sometimes necessary to precompile locally and `git add` to deploy to servers like Heroku
- `public/assets` should not exist in the first place in a development environment, in which one should never run `rake assets:precompile`.

