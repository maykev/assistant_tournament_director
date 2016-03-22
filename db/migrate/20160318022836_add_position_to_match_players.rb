class AddPositionToMatchPlayers < ActiveRecord::Migration
    def change
        add_column :match_players, :position, :integer
    end
end
