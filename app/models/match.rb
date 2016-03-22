class Match < ActiveRecord::Base
  extend Enumerize

  enumerize :status, in: [:created, :in_progress, :finished]

  belongs_to :tournament
  has_many :match_players, dependent: :destroy
  has_many :players, through: :match_players
end
