class AddBracketTypeToTournaments < ActiveRecord::Migration
  def change
      add_column :tournaments, :bracket_type, :string
  end
end
