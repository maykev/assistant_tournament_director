class RemoveMatchTableNumberNullConstraint < ActiveRecord::Migration
  def up
      change_column :matches, :table_number, :integer, null: true
  end

  def down
      change_column :matches, :table_number, :integer, null: false
  end
end
