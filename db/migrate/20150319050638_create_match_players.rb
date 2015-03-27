class CreateMatchPlayers < ActiveRecord::Migration
  def change
    create_table :match_players do |t|
      t.belongs_to :player, null: false
      t.belongs_to :match, null: false
      t.integer :score, default: 0, null: false
      t.timestamps
    end
  end
end
