require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module App
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    ##i18n

      # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
      # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
      # config.i18n.default_locale = :de

      ##fallback

        # If translation does not exist for one language, fallback to another one.

        # rails will fallback to config.i18n.default_locale translation

          #config.i18n.fallbacks = true

        # rails will fallback to en, no matter what is set as config.i18n.default_locale

          #config.i18n.fallbacks = [:en]

        # fallbacks value can also be a hash - a map of fallbacks if you will
        # missing translations of es and fr languages will fallback to english
        # missing translations in german will fallback to french ('de' => 'fr')

          #config.i18n.fallbacks = {'es' => 'en', 'fr' => 'en', 'de' => 'fr'}

    ##assets

        #config.assets.initialize_on_precompile = false
  end
end
