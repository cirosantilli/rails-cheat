class AddStringCol2ToModel0 < ActiveRecord::Migration
  def change
    # Takes: table name, new column name, column type.
    add_column :model0s, :string_col2, :string
  end
end
