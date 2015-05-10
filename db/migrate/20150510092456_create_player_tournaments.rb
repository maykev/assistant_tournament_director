class CreatePlayerTournaments < ActiveRecord::Migration
  def change
    create_table :player_tournaments do |t|
      t.belongs_to :tournament
      t.belongs_to :player

      t.timestamps
    end
  end
end
