class Tournament < ActiveRecord::Base
  extend Enumerize

  enumerize :status, in: [:created, :in_progress, :finished]

  has_many :player_tournaments
  has_many :players, through: :player_tournaments
  has_many :matches
end
