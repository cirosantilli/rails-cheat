# Action mailer testing

# Mail testing

# Email testing

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

You can, and should, use at least two view formats: `text.erb` and `html.erb`. The mailer then sends both on a multipart email and lets the client decide which one to use.
