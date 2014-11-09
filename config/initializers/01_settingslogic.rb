class Settings < Settingslogic
  source "#{Rails.root}/config/settingslogic.yml"

  # This removes part of the namespace of the `settingslogic.yml` file to access settings.
  #
  # For example, if you have:
  #
  #   namespace 'abc'
  #
  # And in `settingslogic.yml`:
  #
  #   abc:
  #     a: 1
  #
  # Then you can access `a` simply as `Settings.a` instead of `Settings.abc.a`
  #
  # The typical usage with sith `Rails.env`.
  #
  namespace Rails.env
end

# Default values if not specified in the yml:

Settings['not_in_yml'] ||= 1
