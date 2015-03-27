class CreateLevels < ActiveRecord::Migration
  def change
    create_table :levels do |t|
      t.string :name, null: false
      t.integer :games_required, null: false
      t.timestamps
    end
  end
end
