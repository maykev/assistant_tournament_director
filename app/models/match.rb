class Match < ActiveRecord::Base
  extend Enumerize

  enumerize :status, in: [:created, :in_progress, :finished]

  has_many :match_players
end
