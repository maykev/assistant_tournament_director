class Match < ActiveRecord::Base
  extend Enumerize

  enumerize :status, in: [:created, :in_progress, :finished]

  has_many :match_players

  scope :with_player, ->(player) { where(player: player) }
end
