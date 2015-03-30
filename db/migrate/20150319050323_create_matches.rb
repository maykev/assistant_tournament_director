class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.integer :table_number, null: false
      t.string :status, null: false
      t.timestamps
    end
  end
end
