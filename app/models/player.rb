class Player < ApplicationRecord
  belongs_to :level, inverse_of: :players
  has_many :match_player
  has_many :player_tournaments
  has_many :tournaments, through: :player_tournaments

  def full_name
    "#{first_name} #{last_name}"
  end
end
