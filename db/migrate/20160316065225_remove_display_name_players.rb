class RemoveDisplayNamePlayers < ActiveRecord::Migration
  def change
      remove_column :players, :display_name, :string
  end
end
