class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :first_name, null: false
      t.string :last_name
      t.string :display_name, length: 10, null: false
      t.string :email
      t.belongs_to :level, null: false
      t.timestamps
    end
  end
end
