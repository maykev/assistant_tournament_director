class AddModeToTournaments < ActiveRecord::Migration
  def change
      add_column :tournaments, :mode, :string
  end
end
