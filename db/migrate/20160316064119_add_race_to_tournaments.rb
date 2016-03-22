class AddRaceToTournaments < ActiveRecord::Migration
  def change
      add_column :tournaments, :race, :integer
  end
end
