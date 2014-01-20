# This is the main cheat on Active Records.

# You should understand at least one SQL language like MySQL before reading this.

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

  # The following tests don't alter the db, so they can all fit into a single test.
  #
  test "readonly" do

    ##table_name

        assert Model0.table_name == "model0s"
        assert Model0.quoted_table_name == '"model0s"'
        assert Model0.primary_key == "id"

    ##retreive from DB to memory

      # The following methods take objects from database and put them into memory.

      # They return arrays of objects from the database.

      # They are not Relations which can be used to build further queries.

      ##find

        # Retreive a single item by its primary ID.

          assert Model0.find(1).integer_col == 1
          assert Model0.find(1, 2).map(&:integer_col) == [1, 2]

      ##take

        # Retreive from database with order unspecified by the query:

          #SELECT * FROM table LIMIT N

        # Default is `N = 1`.

        # `nil` if none present.

      ##first ##last

        # Like take, but order by primary key.

          assert Model0.first.integer_col == 1
          assert Model0.last.integer_col == 2

      ##find_by

        # Same as `where.take`

          assert Model0.find_by(integer_col: 1).string_col == 's1'
          assert Model0.find_by(integer_col: 1, string_col: 's1').string_col == 's1'

        # Helper find_by_FIELD methods are automatically defined for each table field:

          assert Model0.find_by_integer_col(1).string_col == 's1'

        # Redudant with find_by and insaner, so never use it.

      ##pluck

        # Convert `Relation` to `Array` of arrays.

          assert Model0.order(:integer_col).pluck(:integer_col) == [1, 2]
          assert Model0.order(:integer_col).pluck(:integer_col, :string_col) == [[1, 's1'], [2, 's2']]

      ##each

        # each on Relation first retreives all the objects from DB to memory, then loops.

        # Therefore, do not use for entire tables without limit + offset.

        # Consider `find_each` and `find_in_batches` which make several smaller queries.

    ##Relation

      # All query functions such as `all` and `where` return `ActiveRecord::Relation`,
      # not the actual SQL query until the last possible moment.

      # It is thererfore possible to chain multple methods, and get one single optimized SQL statement.

      # It is therefore not possible to convert an array into an `ActiveRecord::Relation`,
      # since the `Relation` is only used to build an SQL query.

      ##to_sql

        # Shows what the SQL query will look like.

          puts "===================="
          puts Model0.where(integer_col: [1, 2]).order(:i).to_sql

        # Note how queries are lazy evaluated: the following produces the same as the above:

          q = Model0.where(integer_col: [1, 2])
          puts q.order(:i).to_sql

      ##raw SQL

        # Using raw SQL is less portable than using Rails methods (which are not themselves perfectly portable).

        # Raw SQL queries can be executed via:

          #ActiveRecord::Base.establish_connection(...)
          #ActiveRecord::Base.connection.execute(...)

      ##method call order

        # TODO confirm: method call order does not affect the generated query.

      ##subqueries

        # Subqueries are done like this: <http://stackoverflow.com/questions/5483407/subqueries-in-activerecord>


      ##all

          @model0s = Model0.all

      ##where

        # Returns a Relation matching criteria.

        # Even if here is a single matching object, it is still a Relation,
        # so you still need to use a function like `take` to get a single object.

        # `where` accecpts many different types of arguments.

        # String:

          assert Model0.where("integer_col = 1 AND string_col = 's1'")[0].string_col == 's1'
          assert Model0.where("integer_col = 1 OR integer_col = 2").order(:integer_col).pluck(:string_col) == ['s1', 's2']

        # Strings are the worst method, since must be parsed and are less convenient to write.

        # They are also less portable since they may execute raw SQL.

        # There are however some capabilities which are currently only available via string input.

        # Array:

          assert Model0.where(["integer_col = ? ", 1]).take.string_col == 's1'
          assert Model0.where(["integer_col = :integer_col", {integer_col: 1}])[0].string_col == 's1'

        # Hash (the best):

          assert Model0.where(integer_col: 1).take.string_col == 's1'
          assert Model0.where(integer_col: [1, 2]).order(:integer_col).pluck(:string_col) == ['s1', 's2']
          assert Model0.where(integer_col: (0..4)).order(:integer_col).pluck(:string_col) == ['s1', 's2']

        # Not:

          assert Model0.where.not(integer_col: 1).take.string_col == 's2'

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

      ##select

        # By default, query methods use `SELECT *`.

        # To reduce the ammount of DB IO, use `select` to select specific columns only.

      ##merge

        # Merge existing relation with another.

          assert Model0.all.merge(Model0.where(integer_col: 1))[0].string_col == 's1'

      ##distinct

          Model0.create(id: 3, integer_col: 1, string_col: 's1')
          Model0.create(id: 4, integer_col: 1, string_col: 's2')

          Model0.order(:integer_col).pluck(:integer_col) == [1, 1, 1, 2]

        # With select does distinct on all columns, excluding `id`:

          Model0.order(:integer_col).distinct.pluck(:integer_col) == [1, 1, 2]

        # With select does distinct on single column:

          Model0.select(:integer_col).order(:integer_col).distinct.pluck(:integer_col) == [1, 2]

          Model0.delete_all(id: [3, 4])

      ##order

          #Model0.order(:integer_col)
          #Model0.order(integer_col: :asc)
          #Model0.order(integer_col: :desc)

      ##reorder

        #TODO vs order

      ##limit ##offset

        # Pagination friends.

          #Model0.all.limit(5).offset(10)

      ##calculations ##aggregate

        ##count

            assert Model0.count == 2
            assert Model0.all.count == 2

        ##sum

            assert Model0.sum(:integer_col) == 3

        ##minimum ##maximum

            assert Model0.minimum(:integer_col) == 1
            assert Model0.maximum(:integer_col) == 2

        ##average

            assert Model0.average(:integer_col) == 1.5

      ##group

        # Does an SQL `GROUP BY`.

          Model0.create(id: 3, integer_col: 2, string_col: 's1')
          assert Model0.group(:string_col).count               == {'s1'=> 2, 's2'=> 1}
          assert Model0.group(:string_col).sum(:integer_col)   == {'s1'=> 3, 's2'=> 2}
          Model0.delete_all(id: [3])

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

    ##create

      # Unlike new, immediately creates the element on the database.

    ##save

      # Saves a model instance to the database, usually one that was created with new.

        #@model0 = Model0.new(model0_params)
        #@model0.save

    ##save! vs save

      # `save!` does validations, `save` does not.

    ##build

  test "#update" do
    # Takes id of record to update:

      assert Model0.update(1, integer_col: 2).integer_col == 2
      assert Model0.find(1).integer_col == 2
  end

  test "#update multiarg" do
      assert Model0.update([1, 2], [{integer_col: 11}, {integer_col: 12}])
      assert Model0.find(1).integer_col == 11
      assert Model0.find(2).integer_col == 12
  end

  test "#update_all" do
    # Updates an argument for all records of the table
      assert Model0.update_all(integer_col: 10)
      assert Model0.find(1).integer_col == 10
      assert Model0.find(2).integer_col == 10
  end

    ##delete

      # Remove record from table.

      # Can only be used for a single record at a time, so no `where.destroy`. Use `delete_all` instead.

    ##destroy

      # Deletes object and all associated objects

    ##delete_all

      # Without arguments, remove all records from table

      # With arguments identical to where, delete only selected subset.

      # Does not do truncate: removes items one by one, in order to trigger
      # possible actions. To truncate consider using the `DatabaseCleaner` gem.
      # with `DatabaseCleaner.clean_with(:truncation, only: [:model0s, :model1s])`.

  test "##changed ##was" do

      # Check for differneces between the object and its DB version.

        model0 = Model0.find(1)
        assert !model0.changed?
        model0.integer_col = 1
        assert !model0.changed?
        model0.integer_col += 1
        assert model0.changed?

      # There also exists a per field version:

        assert !model0.string_col_changed?
        assert model0.integer_col_changed?

      # Find which attributes changed and their DB values:

        assert model0.changed_attributes == {"integer_col" => 1}

      ##changed

        # Was can be used to get the DB value:

          assert model0.integer_col_was == model0.integer_col - 1

        # After saving, there are no changes anymore:

          model0.save
          assert !model0.changed?

        # To get the DB version of the entire object use `model0.dup.reload`.
  end

  test "##reload" do

    # Find object by ID on the database, and update the memory version inplace to match the DB.

      model0 = Model0.find(1)

    # Without save:

      model0.integer_col = 2
      assert model0.reload.integer_col == 1
      assert model0.integer_col == 1

    # With save:

      model0.integer_col = 2
      model0.save
      assert model0.reload.integer_col == 2
      assert model0.integer_col == 2

    # Does a `find_by!`, so raises `RecordNotFound` if the id does not exist on DB:

      model0.id = 1234
      assert_raises(ActiveRecord::RecordNotFound){model0.reload}

    # To not do inplace, use `clone.reload`.
  end
end
