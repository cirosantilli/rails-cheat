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
  #   Methods which can currently be reverted are listed at: <http://guides.rubyonrails.org/migrations.html#using-the-change-method>
  #
  # - define both `up` and `down` methods.
  #    Always works, but you write more.
  #
  def change
    create_table :model0s do |t|

      # TODO `t` is a `TableDefinition` object:
      # http://api.rubyonrails.org/classes/ActiveRecord/ConnectionAdapters/TableDefinition.html
      #
      # ##column
      #
      # Possible way to create columns:
      #
      #     t.column :name, :type
      #
      # But the shorthands of type: `t.string :name` are recommended in the guides instead.
      #
      # ##limit
      #
      #     `:limit` is the maximum length of a string field.
      #
      t.string :string_col
      #t.string :string_limit_32, :string, limit: 32
      t.text :text_col
      t.integer :integer_col
      t.integer :integer_col2
      t.integer :integer_col3
      t.float :float_col
      t.timestamp :timestamp_col
      t.boolean :boolean_col
      #t.column :not_null, :integer, null: false

      # ##Default value
      #
      # The default is passed to the schema, and used for new objects.
      #
      # To create a default from options that can modified after migration,
      # use `after_initialize` as described at <http://stackoverflow.com/questions/328525/how-can-i-set-default-values-in-activerecord>.
      #
      # Note however that those two methods cannot be mixed of this default will always prevail.
      #
      #t.column :default1, :integer, default: 1

      # Many to one relationship.
      t.integer :model1_id

    ##timestamps

      #TODO

        #t.timestamps

    end

    create_table :model1s do |t|
      t.string :string_col
      t.integer :integer_col
      t.integer :not_in_model0
      t.integer :model2_id
      t.integer :model22_id
    end

    create_table :model2s do |t|
      t.string :string_col
      t.integer :integer_col
      t.integer :model3_id
    end

    create_table :model22s do |t|
      t.string :string_col
      t.integer :integer_col
    end

    create_table :model3s do |t|
      t.string :string_col
      t.integer :integer_col
    end

    # It is possible to create some elements here already,
    # however this is not recommended since those elements
    # will not be present on the `db/schema.rb`,
    # nor no the `db/seeds.rb`.
    #
    # Use schemas or `db/seeds.rb` for that instead.
    #
    #Model0.create string_col: 'abc', integer_col: 123

  end

  ##change_column_default

      #def up
        #change_column_default :profiles, :show_attribute, true
      #end

      #def down
        ## Remove the default:
        #change_column_default :profiles, :show_attribute, nil
      #end

  ##add_index

    # http://api.rubyonrails.org/classes/ActiveRecord/ConnectionAdapters/SchemaStatements.html#method-i-add_index

    # Existing table:

      #class ModifyTable < ActiveRecord::Migration
      #  def change
      #    add_index :table, :column
      #  end
      #end

    # New table:

      #class CreateTable < ActiveRecord::Migration
      #  def change
      #    create_table :table do |t|
      #      ...
      #    end
      #    add_index :table, :column
      #  end
      #end

    # Multi column index:

      # add_index :table, [:column0, :column1]

    # Options:

      # add_index :table, :column, options

    # `name`:   index name
    # `unique: true`: `UNIQUE` index constraint
    # `order`:  TODO
end
