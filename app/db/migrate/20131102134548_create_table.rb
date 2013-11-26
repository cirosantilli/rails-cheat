# This class *must* have the same name as this file camel cased.
class CreateTable < ActiveRecord::Migration

  # ##change ##up ##down
  #
  # There are two possibilities:
  #
  # - define only the `change` method.
  #
  #    Only possible for migration in which the inverse is unambiguous (ex: create / drop).
  #
  #    In those cases, RoR is able to determine the inverse without us specifying anything.
  #
  # - define both `up` and `down` methods.
  #    Always works, but you write more.
  #
  def change
    create_table :model0s do |t|

      #  ##column
      #
      # Signature:
      #
      #    name, type, options
      #
      # ##limit
      #
      #     `:limit` is the maximum length of a string field.
      #
      t.column :string_col, :string, limit: 32, null: false
      t.column :text_col, :text
      t.column :integer_col, :integer
      t.column :float_col, :float
      t.column :timestamp_col, :timestamp

      # Many to one relationship.
      t.column :model1_id, :integer

    ##timestamps

      #TODO

        #t.timestamps

    end

    create_table :model1s do |t|
      t.column :string_col, :string, limit: 32, null: false
    end

    # It is possible to create some elements here already,
    # however this is not recommended since those elements
    # will not be present on the `db/schema.rb`,
    # nor no the `db/seeds.rb`.
    #
    # Use schemas or `db/seeds.rb` for that instead.
    #
    Model0.create string_col: 'abc', integer_col: 123
    #Model0.create string_col: 'def', integer_col: 456

    #Model1.create string_col: '0'
    #Model1.create string_col: '1'
    #Model1.create string_col: '2'
    #Model1.create string_col: '3'
  end
end
