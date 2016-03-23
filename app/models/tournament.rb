class Tournament < ActiveRecord::Base
  extend Enumerize

  enumerize :status, in: [:created, :in_progress, :finished]
  enumerize :mode, in: [:full, :semi]

  serialize :table_numbers, Array

  has_many :player_tournaments
  has_many :players, through: :player_tournaments
  has_many :matches
end
