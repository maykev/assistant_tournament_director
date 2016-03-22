class AddTournamentToMatch < ActiveRecord::Migration
  def change
      add_reference :matches, :tournament, index: true
  end
end
