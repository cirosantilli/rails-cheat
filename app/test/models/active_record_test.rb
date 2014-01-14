# This is the main cheat on Active Records.

require 'test_helper'

class ActiveRecordTest < ActiveSupport::TestCase
  def setup
    # Get rid of fixture data.
    DatabaseCleaner.clean_with(:truncation, only: [:model0s, :model1s])
    Model0.create(id: 1, integer_col: 1, string_col: 's1', model1_id: 1)
    Model0.create(id: 2, integer_col: 2, string_col: 's2', model1_id: 2)
    Model1.create(id: 1, integer_col: 1, string_col: 't1')
    Model1.create(id: 2, integer_col: 2, string_col: 't2')
  end

  # The following tests don't alter the db,
  # so they can all fit into a single test.
  #
  test "readonly" do
    # You should understand at least one SQL language like MySQL before using this.

    ##to_sql

      # Shows what the SQL query will look like.

        puts "===================="
        puts Model0.where(integer_col: [1, 2]).order(:i).to_sql

      # Note how queries are lazy evaluated: the following produces the same as the above:

        q = Model0.where(integer_col: [1, 2])
        puts q.order(:i).to_sql

    ##all

        @model0s = Model0.all

    ##find

      # Retreive a single item by its primary ID.

    ##take ##limit

      # SELECT * FROM table LIMIT N

      # Default is `N = 1`.

      # `nil` if non found.

    ##find_by

      # Same as `where.take`

        assert Model0.find_by(integer_col: 1).string_col == 's1'
        assert Model0.find_by(integer_col: 1, string_col: 's1').string_col == 's1'

      # Helper find_by_FIELD methods are automatically defined for each table field:

        assert Model0.find_by_integer_col(1).string_col == 's1'

      # Redudant with find_by and insaner, so never use it.

    ##where

      # Returns an array like object of rows matching a criteria.

      # Even if here is a single matching object, it is still array like,
      # so you still need to use the `[]`.

      # There are many forms of using `where`.

      # String:

        assert Model0.where("integer_col = 1 AND string_col = 's1'")[0].string_col == 's1'
        assert Model0.where("integer_col = 1 OR integer_col = 2").order(:integer_col).pluck(:string_col) == ['s1', 's2']

      # Array:

        assert Model0.where(["integer_col = ? ", 1])[0].string_col == 's1'
        assert Model0.where(["integer_col = :integer_col", {integer_col: 1}])[0].string_col == 's1'

      # Hash:

        assert Model0.where({integer_col: 1})[0].string_col == 's1'
        assert Model0.where({integer_col: [1, 2]}).order(:integer_col).pluck(:string_col) == ['s1', 's2']

      # Error:

        #assert Model0.where(integer_col: 1).string_col == 's1'

      # If you are only interested in a single object, consider using `find_by`.

      ##or query

        # While it is possible to do an `AND` query without using the messy string method
        # by using the hash signature,
        # it is seems that it is not possible to do `OR` queries across multiple columns without plugins
        # and without a string query: <http://stackoverflow.com/questions/3639656/activerecord-or-query>
        #
        # It is possible on a single colum via the hash array construct: `{id: [1, 2]}`.

    ##create

      # Unlike new, immediately creates the element on the database.

    ##save

      # Saves a model instance to the database, usually one that was created with new.

        #@model0 = Model0.new(model0_params)
        #@model0.save

    ##save! vs save

      # `save!` does validations, `save` does not.

    ##count

        #Model0.count
        #Model0.all.count

    ##order

        #Model0.order(:integer_col)
        #Model0.order(integer_col: :asc)
        #Model0.order(integer_col: :desc)

    ##limit ##offset

      # Pagination friends.

        #Model0.all.limit(5).offset(10)

    ##pluck

      #   Person.pluck(:name)
      #
      # is the same astring_col:
      #
      #   Person.all.map(&:name)
      #
      # except that the first may be faster as it only fetches
      # required rows from the server.
      #
      # Example:
      #
      #   Person.pluck(:i)
      #   # SELECT people.i FROM people
      #   # => [1, 2, 3]
      #
      # Multi row example:
      #
      #   Person.pluck(:i, :name)
      #   # SELECT people.i, people.name FROM people
      #   # => [[1, 'David'], [2, 'Jeremy'], [3, 'Jose']]

    ##destroy

      # Remove record from table.

    ##destroy_all

      # Remove all records from table.

      # Does not do truncate: removes items one by one, in order to trigger
      # possible actions. To truncate consider using the `DatabaseCleaner` gem.
      # with `DatabaseCleaner.clean_with(:truncation, only: [:model0s, :model1s])`.

    ##associations

      # <http://guides.rubyonrails.org/association_basics.html>

      ##belongs_to

        # `belogs_to :model1` in Model0, gives it the `model1` method:

          assert Model0.find_by(string_col: 's1').model1.string_col == 't1'

        # `has_many :model0s` gives the `model0s` method to `Model1`:

          assert Model1.find_by(string_col: 't1').model0s.take.string_col == 's1'

    ##joins

      # Does SQL joins on data.

      # Requires that the table rows be associated via `belongs_to` family methods.

        assert Model0.joins(:model1).find_by(model1s: {string_col: 't1'}).string_col == 's1'
        #                                           ^
        #                                           This is the Model0 s column

        assert Model1.joins(:model0s).find_by(model0s: {string_col: 's1'}).string_col == 't1'
        #                                           ^
        #                                           This is the Model1 s column.
  end
end
