class AddEnableEmailToPlayers < ActiveRecord::Migration
  def change
      add_column :players, :enable_email, :boolean
  end
end
