class AddFinalRaceToTournaments < ActiveRecord::Migration
  def change
      add_column :tournaments, :final_race, :integer
  end
end
