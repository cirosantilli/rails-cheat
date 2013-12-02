module Heroku
  # Return true iff the app is currently running on heroku.
  #
  def self.heroku?
    ENV.has_key?('HEROKU_POSTGRESQL_TEAL_URL')
  end
end
