# rails utility

## new

Create a new project template:

    rails new project-name

Use a specific RDMS:

    rails new myapp --database=postgresql

## server

Run test server:

    cd project-name
    bundle exec rails server

Shortcut:

    bundle exec rails s

By default this serves on port `3000`. You can chose a custom one with:

    bundle exec rails server -p 4000

If you have certain gems installed, you can use another server other than the default WEBrick with:

    bundle exec rails thin
    bundle exec rails mongrel

<http://stackoverflow.com/questions/7047496/how-to-set-thin-as-default-in-rails-3>

<http://stackoverflow.com/questions/15858887/how-can-i-use-unicorn-as-rails-s>

Daemonize Rails:

    bundle exec rails server -d

To stop it later do:

    kill `cat tmp/pids/server.pid`

## generate

## destroy

Generate a controller template with one action:

    rails generate controller controller-name action-name

Shortcut:

    rails g controller controller-naue action-name

Delete files created with generate:

    rails destroy controller controller-name

Shortcut:

    rails d controller controller-name

## console

Open a live terminal in which to interact with the application:

    rails console
    rails c

Allow you for example to run database queries to do quick tests.

Useful things you can do from the console include:

- `app` allows you to do things like in integration tests such as:`app.get '/path'; app.response.body`
- `helper.button_tag` to try out helpers available inside views

>> app.response.body

If you want to run a single command quickly you can do:

    rails runner 'puts 0'
    rails r 'puts 0'

To run a script file <http://stackoverflow.com/questions/10313181/pass-ruby-script-file-to-rails-console> do:

    bundle exec rails runner "eval(File.read 'your_script.rb')"

