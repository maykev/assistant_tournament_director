class AddTableNumbersToTournaments < ActiveRecord::Migration
  def change
      add_column :tournaments, :table_numbers, :text
  end
end
