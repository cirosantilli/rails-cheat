# This is the main cheat on Active Records.# You should understand at least one SQL language like MySQL before reading this.

require 'test_helper'

class ActiveRecordTest < ActiveSupport::TestCase

  # Minimalistic test data.
  #
  def setup
    DatabaseCleaner.clean_with(:truncation, only: [:model0s])
    Model0.create(id: 1, integer_col: 1, string_col: 's1')
    Model0.create(id: 2, integer_col: 2, string_col: 's2')
  end

  # Runs given block while logging queries made.
  #
  def stdout_log(title)
    puts("====================#{title}")
    ActiveRecord::Base.logger = Logger.new(STDOUT)
    yield
    ActiveRecord::Base.logger = nil
    puts("====================")
  end

  # The following tests:
  #
  # - don't alter the db
  # - involve only a single table
  #
  test "single table readonly" do

    ##table info

      ##table_name

          assert_equal Model0.table_name, "model0s"
          assert_equal Model0.quoted_table_name, '"model0s"'

      ##primary_key

          assert_equal Model0.primary_key, "id"

    ##retreive from DB to memory

      # The following methods take objects from database and put them into memory.

      # They return arrays of objects from the database.

      # They are not Relations which can be used to build further queries.

      ##to_a

        # Transforms entire query into array.

        # Not as often used as `find_each`.

          assert_equal Model0.order(:integer_col).to_a, Model0.order(:id).find(1, 2)

      ##find

        # Retreive a single item by its primary ID.

          assert_equal Model0.find(1).integer_col, 1

        # Order is not guarnateed to be the same as provided. SImply does SQL `WHERE IN`.

          assert_equal Model0.order(:id).find(1, 2).map(&:integer_col), [1, 2]

      ##take

        # Retreive from database. Does not specify an order.

        # If no order was used on the query, the output is unpredictable.

          #SELECT * FROM table LIMIT N

        # Default is `N = 1`.

        # `nil` if none present.

      ##first ##last

        # Like take, but order by primary key.

          assert_equal Model0.first.integer_col, 1
          assert_equal Model0.last.integer_col, 2

      ##find_by

        # Same as `where.take`

          assert_equal Model0.find_by(integer_col: 1).string_col, 's1'
          assert_equal Model0.find_by(integer_col: 1, string_col: 's1').string_col, 's1'

        # Helper find_by_FIELD methods are automatically defined for each table field:

          assert_equal Model0.find_by_integer_col(1).string_col, 's1'

        # Redudant with find_by and insaner, so never use it.

      ##find_by_sql

          model0s = Model0.find_by_sql("SELECT * FROM model0s WHERE model0s.id = 1")
          assert_equal model0s.class, Array
          assert_equal model0s.map(&:string_col).sort, ['s1']

        # TODO why fails with prepared statement?:

          assert_raises(ActiveRecord::StatementInvalid){Model0.find_by_sql("SELECT * FROM model0s WHERE model0s.id = ?", 1)}

        # Convert `Relation` to `Array` of arrays.

      stdout_log("##pluck") do
        # Take only certain columns from the Relation,
        # and transforms them into an array of arrays of column values.
        # Also does a select query, returning only the necessary fields.
          assert_equal Model0.order(:integer_col).pluck(:integer_col), [1, 2]
          assert_equal Model0.order(:integer_col).pluck(:integer_col, :string_col), [[1, 's1'], [2, 's2']]
      end

      ##each

        # each on Relation first retreives all the objects from DB to memory, then loops.

        # Therefore, do not use for entire tables without limit + offset.

        # Consider `find_each` and `find_in_batches` which make several smaller queries.

      ##find_each ##find_in_batches

        # Both methods find in fixed size batches so as not to overflw memory.
        # `find_each` is just an iteration over a `find_in_batches` returned array.

        # Find in batches passes regular Array to the loop variable, not queries.

          model0s_expected = []
          klass = nil
          Model0.find_in_batches(batch_size: 1) do |model0s|
            klass = model0s.class
            model0s_expected << model0s.first
          end
          assert_equal model0s_expected, Model0.order(:id).find(1, 2)
          assert_equal klass, Array

          model0s = []
          Model0.find_each(batch_size: 1) do |model0|
            model0s << model0
          end
          assert_equal model0s, Model0.order(:id).find(1, 2)

        # As of 4.0.2:

        # - always reorders by primary key
        # - limits are ignored (obviously, since we already have batch_size)

        # Works even if primary column is renamed:

          Model0.select('id AS id_new').find_in_batches() do |batch|
          end

          Model0.select('model0s.id AS id_new').find_in_batches() do |batch|
          end

        # Since this function is a bit restricted by the fixed order,
        # we might also want to do this manually:

          offset = 0
          limit = 1
          query = Model0.order(:string_col).limit(limit)
          model0_ids = []
          while (model0s = query.offset(offset).to_a).any?
            model0_ids += model0s.map(&:id)
            offset += limit
          end
          assert_equal model0_ids, [1, 2]

        # And a `find_each` would look like:

          offset = 0
          limit = 1
          query = Model0.order(:string_col).limit(limit)
          model0_ids = []
          while (model0s = query.offset(offset).to_a).any?
            model0s.each do |model0|
              model0_ids << model0.id
            end
            offset += limit
          end
          assert_equal model0_ids, [1, 2]

    ##Relation

      # All query functions such as `all` and `where` return `ActiveRecord::Relation`,
      # not the actual SQL query until the last possible moment.

      # It is thererfore possible to chain multple methods, and get one single optimized SQL statement.

      # It is therefore not possible to convert an array into an `ActiveRecord::Relation`,
      # since the `Relation` is only used to build an SQL query.

      ##to_sql

        # Shows what the SQL query will look like.

          #puts Model0.where(integer_col: [1, 2]).order(:i).to_sql

        # Note how queries are lazy evaluated: the following produces the same as the above:

          q = Model0.where(integer_col: [1, 2])
          #puts q.order(:i).to_sql

      ##logger

        # Print all generated queries in a code region to stdout:

            #ActiveRecord::Base.logger = Logger.new(STDOUT)
            #Model0.all.to_a
            #ActiveRecord::Base.logger = nil

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

        # All is almost useless.

        # In the past it returned an array, now it returns a relation, but all queries
        # can be made directly such as via `Model.where`.

        # Perhaphs the only use case for `all` is to get all elements into an array
        # via `Model0.all.to_a`, but this is a rare operation since it could overflow memory.

      ##where

        # Returns a Relation matching criteria.

        # Even if here is a single matching object, it is still a Relation,
        # so you still need to use a function like `take` to get a single object.

        # `where` accecpts many different types of arguments.

        # String:

          assert_equal Model0.where("integer_col = 1 AND string_col = 's1'")[0].string_col, 's1'
          assert_equal Model0.where("integer_col = 1 OR integer_col = 2").order(:integer_col).pluck(:string_col), ['s1', 's2']

        # Array with first element being a string: (#prepared statement)

          assert_equal Model0.where(["integer_col = ? ", 1]).take.string_col, 's1'
          #assert_equal Model0.where(["integer_col = ? ", [1, 2]]).order(:integer_col).to_a, Model0.order(:id).find(1, 2)
          # Placeholders:
          assert_equal Model0.where(["integer_col = :integer_col", {integer_col: 1}])[0].string_col, 's1'

        # Strings are the worst method, since must be parsed and are less convenient to write.

        # They are also less portable since they may execute raw SQL.

        # There are however some capabilities which are currently only available via string input:

        # - greater than / less than: <http://stackoverflow.com/questions/4224600/can-you-do-greater-than-comparison-on-a-date-in-a-rails-3-search>
        # - `COALESCE`

        # Hash (the best):

          assert_equal Model0.where(integer_col: 1).take.string_col, 's1'
          assert_equal Model0.where(integer_col: [1, 2]).order(:integer_col).pluck(:string_col), ['s1', 's2']
          assert_equal Model0.where(integer_col: (0..4)).order(:integer_col).pluck(:string_col), ['s1', 's2']

        # Not:

          assert_equal Model0.where.not(integer_col: 1).take.string_col, 's2'

        # Error:

          #assert_equal Model0.where(integer_col: 1).string_col, 's1'

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

        # Select allows you to rename columns. Specially useful with join and aggregate functions.

        # A new method is added to the resulting objects of this query:

          assert_equal Model0.select("integer_col AS i").first.i, 1
          assert_raises(ActiveModel::MissingAttributeError){Model0.select("integer_col AS i").first.integer_col == 1}

        # Other columns are gone from the end object:

          assert_raises(ActiveModel::MissingAttributeError){Model0.select("integer_col AS i").first.string_col}

        # TODO why do the following not work?

          #assert_equal Model0.order(:integer_col).select("integer_col AS i").pluck(:i), [1, 2]
          #assert_equal Model0.select("integer_col AS i").order(:i).find_by(i: 1).string_col, 's1'
          assert_equal Model0.order(:integer_col).select("integer_col AS i").pluck(:integer_col), [1, 2]

        # Even if you select only a single column, it is still possible to pluck by others:

          assert_equal Model0.order(:integer_col).select(:integer_col).pluck(:string_col), ['s1', 's2']

      ##merge

        # Merge existing relation with another.

          assert_equal Model0.all.merge(Model0.where(integer_col: 1))[0].string_col, 's1'

      ##distinct

          Model0.order(:integer_col).pluck(:integer_col) == [1, 1, 1, 2]

        # With select does distinct on all columns, excluding `id`:

          Model0.order(:integer_col).distinct.pluck(:integer_col) == [1, 1, 2]

        # With select does distinct on single column:

          Model0.select(:integer_col).order(:integer_col).distinct.pluck(:integer_col) == [1, 2]

          Model0.delete_all(id: [3, 4])

      ##order

          assert_equal Model0.order(:integer_col).to_a,       Model0.order(:id).find(1, 2)
          assert_equal Model0.order(integer_col: :asc).to_a,  Model0.order(:id).find(1, 2)
          assert_equal Model0.order(integer_col: :desc).to_a, [Model0.find(2), Model0.find(1)]

        # By multiple columns:

          assert_equal Model0.order(:integer_col, :string_col).to_a, Model0.order(:id).find(1, 2)

      ##reorder

        #TODO vs order

      ##limit ##offset

        # Pagination friends.

          #Model0.all.limit(5).offset(10)

      ##calculations ##aggregate

        ##count

            assert_equal Model0.count, 2
            assert_equal Model0.all.count, 2

        ##sum

            assert_equal Model0.sum(:integer_col), 3

          # DEPRECATED: use group instead.

            #assert_equal Model0.sum(:integer_col, group: :string_col), {'s1' => 1, 's2' => 2}

        ##minimum ##maximum

            assert_equal Model0.minimum(:integer_col), 1
            assert_equal Model0.maximum(:integer_col), 2

        ##average

            assert_equal Model0.average(:integer_col), 1.5

      ##group

        # Does an SQL `GROUP BY`. The calculation returns a Hash.

          Model0.create(id: 3, integer_col: 2, string_col: 's1')
          assert_equal Model0.group(:string_col).count              , {'s1'=> 2, 's2'=> 1}
          assert_equal Model0.group(:string_col).sum(:integer_col)  , {'s1'=> 3, 's2'=> 2}
          Model0.delete_all(id: [3])

        # A common combo is to count by first order association via the foeign key.
        # Here we sum up `integer_col` on `Model0` for each `Model2`.

          #assert_equal Model0.group(:model1_id).sum(:integer_col), {1=>3, 2=>7}
  end

  # Creates interesting data for when there are many tables.
  #
  def setup_multitable_data
    DatabaseCleaner.clean_with(:truncation)

    Model0.create(id: 1, integer_col: 1, string_col: 's1', model1_id: 1)
    Model0.create(id: 2, integer_col: 2, string_col: 's2', model1_id: 1)
    Model0.create(id: 3, integer_col: 3, string_col: 's3', model1_id: 2)
    Model0.create(id: 4, integer_col: 4, string_col: 's4', model1_id: 2)
    Model0.create(id: 5, integer_col: 5, string_col: 's1', model1_id: 1)
    Model0.create(id: 6, integer_col: 6, string_col: 's2', model1_id: 1)
    Model0.create(id: 7, integer_col: 7, string_col: 's3', model1_id: 2)
    Model0.create(id: 8, integer_col: 8, string_col: 's4', model1_id: 2)

    Model1.create(id: 1, integer_col: 1, string_col: 't1', model2_id: 1, model22_id: 1, not_in_model0: 1)
    Model1.create(id: 2, integer_col: 2, string_col: 't2', model2_id: 2, model22_id: 2, not_in_model0: 2)
    Model1.create(id: 3, integer_col: 3, string_col: 't3', model2_id: 1, model22_id: 1, not_in_model0: 3)
    Model1.create(id: 4, integer_col: 4, string_col: 't4', model2_id: 2, model22_id: 2, not_in_model0: 4)
    # No children:
    Model1.create(id: 5, integer_col: 5, string_col: 't5', model2_id: 3, model22_id: 3, not_in_model0: 5)

    Model2.create(id: 1, integer_col: 1, string_col: 'u1', model3_id: 1)
    Model2.create(id: 2, integer_col: 2, string_col: 'u2', model3_id: 1)
    # No grand children:
    Model2.create(id: 3, integer_col: 3, string_col: 'u3', model3_id: 1)
    # No children:
    Model2.create(id: 4, integer_col: 4, string_col: 'u4', model3_id: 1)

    Model22.create(id: 1, integer_col: 1, string_col: 'u1')
    Model22.create(id: 2, integer_col: 2, string_col: 'u2')
    Model22.create(id: 3, integer_col: 3, string_col: 'u3')

    Model3.create(id: 1, integer_col: 1, string_col: 'v1')
    Model3.create(id: 2, integer_col: 2, string_col: 'v2')
  end

  # Tests functions that use multiple tables.
  #
  test "#multitable" do

    setup_multitable_data

    ##associations

      # <http://guides.rubyonrails.org/association_basics.html>

      ##has_one vs belongs_to

        # The only difference is which table contains the foreign key:
        #
        # - belongs_to: current table has the foreign key
        # - has_one   : other   table

      ##patterns

        # - one  to one : 2 tables: one belongs_to + one has_one
        #
        # - one  to many: 2 tables: one belongs_to + one has_many
        #
        # - many to many: 3 tables: two has_many through, and one belongs to the other two

      ##examples

        # `belogs_to :model1` in Model0, gives it the `model1` method:

          assert_equal Model0.find_by(string_col: 's1').model1.string_col, 't1'

        # `has_many :model0s` gives the `model0s` method to `Model1`.

        # This generates a new query `Model.where(id:)` since there are multiple possible model0s:

          assert_equal Model1.find_by(string_col: 't1').model0s.find_by(integer_col: 1).string_col, 's1'
          assert_equal Model1.find_by(string_col: 't1').model0s.find_by(integer_col: 3), nil

        # It is only possible to use associations once you have an specific object,
        # not from Relation objects:

          assert_raises(NoMethodError){Model0.all.model1}
          assert_raises(NoMethodError){Model1.all.model0s}

      ##through

        # Allows to access a second level relation directly.

        # `belongs_to :through` does not exist because it does not make sense,
        # since the current table does not contain the foreign key.
        # Just use `has_one :through` instead.

        # Produces efficient queries:
        # - for the N+1 problem.
        # - only returns all columns `tables.*` from the endpoints, not from the middle columns.

        stdout_log("through") do

          assert_equal Model2.find(1).model0s.pluck(:id).sort, [1, 2, 5, 6]
          end

          assert_equal Model3.find(1).model0s.pluck(:id).sort, (1..8).to_a

          assert_equal Model0.find(1).model2.integer_col, 1

          assert_equal Model0.find(1).model3.integer_col, 1

          # Only does one extra query per batch.
          stdout_log("through each") do
          model0_is = []
          Model2.find(1).model0s.find_each(batch_size: 2) do |model0|
            model0_is << model0.integer_col
          end
          assert_equal model0_is, [1, 2, 5, 6]

        end

        # The following fails without an explicit joins or includes.

          #Model0.order('model2s.id').pluck(:integer_col)
          #Model0.where(model2s: {id: 1}).pluck(:integer_col)

    # Includes vs joins:

    # - use includes when you want to get the entire object of the other side of the relation.
    #
    #    This will return a large number of SQL columns, but there is no workaround if you want the object.
    #
    # - use joins when you only want a fields of the other side of the relation.
    #
    #    This will return a small nmber of SQL columns, but you cannot have the object on the other side.

    ##joins

      # Does SQL `INNER JOIN` on data.

      # It seems that `LEFT JOIN` is only possible via explicit SQL:
      # http://stackoverflow.com/questions/1509692/rails-activerecord-joins-with-left-join-instead-of-inner-join

      # Requires that the table rows be associated via `belongs_to` family methods.

      # Fails because table not specified:

      # Best way to go:

        assert_equal Model0.joins(:model1).find_by(model1s: {string_col: 't1'}).string_col, 's1'
        #                                         ^
        #                                         This is the Model1 column

        assert_equal Model1.joins(:model0s).find_by(model0s: {string_col: 's1'}).string_col, 't1'
        #                                          ^
        #                                          This is the Model0 column.

      # Works: but not very neat:

        assert_equal Model0.joins(:model1).find_by(:'model1s.string_col' => 't1').string_col, 's1'

      # If the table is omitted, considers columns of the side that originated the queries.

        assert_equal Model0.joins(:model1).find_by(string_col: 's1').integer_col, 1

      # Even if joins were made, the end object is always from the class that started the query.
      # This maintains the default of doing a `SELECT CallingTable.*` query by default.

        assert_raises(NoMethodError){Model0.joins(:model1).find_by(model1s: {string_col: 't3'}).not_in_model0}

      # Unlike `includes`, `joins` considers `select`, and this allows to make certain fields of the has_many
      # side directly available without any extra queries:

        stdout_log("joins + select") do
          model1_ids = []
          Model0.joins(:model1).select('model1s.id AS model1_id').find_each do |model0|
            model1_ids << model0.model1_id
          end
          assert_equal model1_ids, [1, 1, 2, 2] * 2
        end

      # Unlike `includes`, `joins` does not eager load data automatically for us, so the following generates N queries:
      # BAD BAD BAD!

        stdout_log("joins + association") do
          model1_ids = []
          Model0.joins(:model1).find_each do |model0|
            model1_ids << model0.model1.id
          end
          assert_equal model1_ids, [1, 1, 2, 2] * 2
        end

      # Joins + group + sum is a common combo to count on multi level belongs to has many.
      # Here we sum up `:integer_col` in `Model0` for each `Model2`.
      # Note how Model2s with not Model0s are not present because `INNER JOIN` is performed.

        assert_equal Model0.joins(:model1).group(:model2_id).sum(:integer_col), {1=>(1+2+5+6), 2=>(3+4+7+8)}
        #assert_equal Model2.joins(:model1s).select('model2s.id, model0s.integer_col').joins(:model0s).group('model2s.id').sum('model0s.integer_col'), {1=>10}

    ##includes ##preload ##eager_load

      # Eager loads relations to make less DB queries.

      # - includes: heurisitcally decides what query to do. Usually the best option.

      # - preload: always does 2 queries `WHERE` + `WHERE IN`.

        # Not possible to use `where` clauses with the other table.

      # - eager: always uses `LEFT OUTER JOIN`

      # Good: only makes 2 queries:

      stdout_log("includes") do
        model1_ids = []
        Model0.includes(:model1).find_each do |model0|
          model1_ids << model0.model1.id
        end
        assert_equal model1_ids, [1, 1, 2, 2] * 2
      end

      stdout_log("where on the other side") do
        model0_ids = []
        Model0.includes(:model1).where(model1s: {id: 1}).find_each do |model0|
          model0_ids << model0.id
        end
        assert_equal model0_ids, [1, 2, 5, 6]
      end

      stdout_log("order by the other side") do
        assert_equal Model0.includes(:model1).order('model1s.id DESC', :id).pluck(:id), [3, 4, 7, 8, 1, 2, 5, 6]
      end

      stdout_log("##references") do
          # Raises a deprecation warning since it cannot know wether to use `JOIN` or `WHERE` without parsing the SQL.
          # and the SELECT would require a `JOIN`.

            assert_equal Model0.includes(:model1).select("model0s.integer_col AS i, model1s.*").find(1).integer_col, 1
      end

            Model0.includes(:model1).where("model0s.id = 1").take.integer_col

      stdout_log("select + references") do
          # The select is ignored: columns are not renamed, and `SELECT *` is done so every column is accessible.
          # This is unlike `joins`, in which `select` is considered.
          model0 = Model0.includes(:model1).select("model0s.integer_col AS i, model1s.id") \
              .references(:model0s, :model1s).find(1)
          assert_raises(NoMethodError){model0.i}
          assert_equal model0.integer_col, 1
          assert_equal model0.string_col, 's1'
          assert_equal model0.model1.string_col, 't1'
      end

      # Fails because missing attribute model1.id. TODO But why, since selects are ignored?

        assert_raises(ActiveModel::MissingAttributeError){
          Model0.includes(:model1).select("model0s.integer_col AS i").references(:model0s).find(1)
        }

      stdout_log("nested includes") do
        # Rails can decide between 3 WHERE clauses or a single JOIN here.
        ids = []
        Model0.includes(model1: :model22).find_each do |model0|
          ids << model0.model1.model22.id
        end
        assert_equal ids, [1, 1, 2, 2] * 2
      end

      stdout_log("nested includes + where on has many side") do
        # Rails is smart, and the where forces the query to be a single JOIN,
        # since it would not be possible to do this efficiently with the WHERE strategy.
        model2_ids = []
        Model0.includes(model1: :model22).where(model22s: {id: 1}).find_each do |model0|
          model2_ids << model0.id
        end
        assert_equal model2_ids, [1, 2, 5, 6]
      end

      stdout_log("nested includes + order") do
        assert_equal Model0.includes(model1: :model2).order('model2s.id DESC', :id).pluck(:id), [3, 4, 7, 8, 1, 2, 5, 6]
      end

      # Including from the has many side is possible, but then each usage of the has many relation fires a new query.
      # There is no logical way around this.

        stdout_log("includes belongs to from has many side") do
          # Includes also works from the `has_many` side, the following makes only a fixed number of queries:
          model0_ids = []
          Model1.includes(:model0s).find_each do |model1|
            model0_ids += model1.model0s.pluck(:id)
          end
          assert_equal model0_ids, [1, 2, 5, 6, 3, 4, 7, 8]
        end

      # Same:

        model0_ids = []
        Model1.includes(:model0s).find_each do |model1|
          model1.model0s.find_each do |model0|
            model0_ids << model0.id
          end
        end
        assert_equal model0_ids, [1, 2, 5, 6, 3, 4, 7, 8]
  end

  test "##create" do
    # Unlike new, immediately creates the element on the database.
    #
    # It does not seem to be currently possible to create multiple objects with a single query:
    # even if the array interface is used:
    # http://stackoverflow.com/questions/2509320/saving-multiple-objects-in-a-single-call-in-rails
    stdout_log("create") do
      Model0.create([
        {integer_col: 1, string_col: 's1'},
        {integer_col: 2, string_col: 's2'},
      ])
    end
  end

    ##save

      # Saves a model instance to the database, usually one that was created with new
      # or modified.

        #@model0 = Model0.new(model0_params)
        #@model0.save

    ##save! vs save

      # `save!` does validations, `save` does not.

    ##build

  test "#update" do

    # Takes id of record to update:

      assert_equal Model0.update(1, integer_col: 2).integer_col, 2
      assert_equal Model0.find(1).integer_col, 2
  end

  test "#update multiarg" do
      assert Model0.update([1, 2], [{integer_col: 11}, {integer_col: 12}])
      assert_equal Model0.find(1).integer_col, 11
      assert_equal Model0.find(2).integer_col, 12
  end

  test "#update_all" do
    # Updates an argument for all records of the table
      assert Model0.update_all(integer_col: 10)
      assert_equal Model0.find(1).integer_col, 10
      assert_equal Model0.find(2).integer_col, 10
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

        assert_equal model0.changed_attributes, {"integer_col" => 1}

      ##changed

        # Was can be used to get the DB value:

          assert_equal model0.integer_col_was, model0.integer_col - 1

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
      assert_equal model0.reload.integer_col, 1
      assert_equal model0.integer_col, 1

    # With save:

      model0.integer_col = 2
      model0.save
      assert_equal model0.reload.integer_col, 2
      assert_equal model0.integer_col, 2

    # Does a `find_by!`, so raises `RecordNotFound` if the id does not exist on DB:

      model0.id = 1234
      assert_raises(ActiveRecord::RecordNotFound){model0.reload}

    # To not do inplace, use `clone.reload`.
  end
end
