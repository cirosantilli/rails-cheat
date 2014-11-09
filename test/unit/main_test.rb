require 'test_helper'

# This is the main cheat for tests.

# Read the tutorial as soon as you can:
# http://guides.rubyonrails.org/testing.html

# ##ActiveSupport::TestCase
#
#   Inherits `MiniTest::Unit::TestCase`.
#
#   Is the base class of other Rails specific test classes like
#   `Controller0ControllerTest` which adds controller tests.
#
#   For generic tests like thos under `lib`,
#   this is the recommended base class.
class MainTest < ActiveSupport::TestCase

  # safe_join
  include ActionView::Helpers::OutputSafetyHelper

  ##test method

    # http://api.rubyonrails.org/classes/ActiveSupport/Testing/Declarative.html#method-i-test

    # Rails specific, simply defines a MiniTest method:

      test 'test method' do
        assert true
      end

    # Same as (would conflict):

      #def test_method
        #assert true
      #end

    # Raionale: `test` is more readable. But just use `def test_` since saner.

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

      ##html_safe ##html_escape ##SafeBuffer

      def test_html_safe
        refute '<'.html_safe?
        assert '<'.html_safe.html_safe?
        assert_equal '<'.html_safe.class, ActiveSupport::SafeBuffer

        assert '<'.html_safe == '<'

        # html_escape only escapes raw `String`, not `SafeBuffer`:

          ERB::Util.html_escape('<') == '&lt;'
          ERB::Util.html_escape('<'.html_safe) == '<'

        # Concatenation works like this:

          s = '<' + '>'.html_safe
          refute s.html_safe?
          assert_equal ERB::Util.html_escape(s), '&lt;&gt;'

          s = '<'.html_safe + '>'
          assert s.html_safe?
          assert_equal ERB::Util.html_escape(s), '<&gt;'
          assert_equal ERB::Util.html_escape('<'.html_safe + '>'.html_safe), '<>'

        ##safe_join

          # <http://api.rubyonrails.org/classes/ActionView/Helpers/OutputSafetyHelper.html#method-i-safe_join>

            assert_equal ERB::Util.html_escape(['<'.html_safe, '>'.html_safe].
                                               join('&'.html_safe)), '&lt;&amp;&gt;'

            assert_equal safe_join(['<'.html_safe, '>'.html_safe], '&'.html_safe), '<&>'
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

      # Monkey patched into Numeric
      # http://api.rubyonrails.org/classes/Numeric.html#method-i-kilobytes

      def bytes
        assert_equal(1.kilobyte, 1024)
        assert_equal(1.kilobytes, 1024)
        assert_equal(1.megabyte, 2**20)
      end
end
