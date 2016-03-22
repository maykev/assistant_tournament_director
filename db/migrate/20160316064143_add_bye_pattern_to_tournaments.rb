class AddByePatternToTournaments < ActiveRecord::Migration
  def change
      add_column :tournaments, :bye_pattern, :string
  end
end
