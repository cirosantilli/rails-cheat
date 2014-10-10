# This is the main cheat for tests.

# Read the tutorial as soon as you can:
# http://guides.rubyonrails.org/testing.html

class MainTest < MiniTest::Unit::TestCase
  ##Autoload

    # Rails has a Rails-specific constant autoloading system.

    # Good tutorial: <http://urbanautomaton.com/blog/2013/08/27/rails-autoloading-hell/>

    # Advantages:

    # -   you don't need to use `require` anywhere if your paths match the name of your classes

    # -   if you add a new class it will get loaded without restarting the app

    #     For reloading existing constants see:
    #     <http://stackoverflow.com/questions/3282655/ruby-on-rails-3-reload-lib-directory-for-each-request>

    # Default paths: every directory under `app`, therefore in particular `models` and `controllers`.

    # Therefore in particular: `lib` is *not* on the default load path.

    # If you create subdirectories like:

    #     app/ab_cd/ef_gh/ij_kl.rb

    # then you *must* declare the class `IjKl` as:

    #     module EfGh
    #       class IjKl

    # The paths can be modified by:

    # - `config.autoload_paths`
    # - `config.eager_load_paths`
    # - `config.load_once_paths`

    # Somewhat documented at:
    # <http://edgeguides.rubyonrails.org/configuring.html>

    # Rails' constant autoloading.

      def test_loaded
        assert_equal TestLib::VAR, 0
      end

      def test_dir_loaded
        assert_equal TestDir::TestLib::VAR, 0
      end

      def test_app_any_name_loaded
        assert_equal InAppAnyName::VAR, 0
      end

    # This comes from the `Bundler.require(:default, Rails.env)`
    # line on `config/application.rb`.

      def test_gemfile_lib_loaded
        Haml
      end

      def test_stdlib_lib_loaded
        OpenStruct
      end

  ##Monkey patches

    # These tests are for Rails monkey patches to standard Ruby libraries.

      ##blank? ##present?

      def test_blank_present

        # Implemeted by Rails for all objects.

        # Implements a Python-like truthy: nil, [], {}, and '' are all false.

        # `present?` is the negation.

          assert !0.blank?
          assert nil.blank?
          assert [].blank?
          assert [].blank?
      end

      ##to_json

      def test_to_json
        # Works on any type. Converts strings and integers to corresponding JSON fragment data types
          assert_equal 1.to_json, '1'
          assert_equal 'ab'.to_json, '"ab"'
      end

      ##model_name

      def model_name
        # Model.model_name returns an `ActiveModel::Name` object with many useful name variations.
        # Human readable fields are i18n aware.
        # http://api.rubyonrails.org/classes/ActiveModel/Name.html
        assert_equal(TwoWord.model_name.human, 'Two word')
        assert_equal(TwoWord.model_name.param_key, 'two_word')
      end
end
