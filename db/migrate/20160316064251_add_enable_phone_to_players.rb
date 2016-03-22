class AddEnablePhoneToPlayers < ActiveRecord::Migration
  def change
      add_column :players, :enable_phone, :boolean
  end
end
