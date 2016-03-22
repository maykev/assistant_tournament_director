class RemoveMatchTableNumberNullConstraint < ActiveRecord::Migration
  def up
      change_column :matches, :table_number, :string, null: true
  end

  def down
      change_column :matches, :table_number, :string, null: false
  end
end
