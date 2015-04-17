# Devise

User signup and authentication.

Gemfile: `gem devise`.

    rails generate devise:install
    rails generate devise:views
    rails generate devise User

where `User` is the model that will represent the user.

## Email confirmation

Get action mailer working.

`app/models`: uncomment `:confirmable`

Migration file: uncomment the `:confirmable` section.

`config/initializers/devise.rb`:

- config.mailer = 'Devise::Mailer'

## Unregistered users

Just don't add:

    before_filter: authenticate!

and unauthenticated users can view pages normally.

## Letter Opener

Open emails on the browser instead of sending them: <https://github.com/ryanb/letter_opener>

The sent email has a link on the top right to toggle between text and HTML versions.

## OmniAuth

TODO
