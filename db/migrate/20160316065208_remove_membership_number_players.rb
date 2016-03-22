class RemoveMembershipNumberPlayers < ActiveRecord::Migration
  def change
      remove_column :players, :membership_number, :string
  end
end
