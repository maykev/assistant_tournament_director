class Tournament < ActiveRecord::Base
    extend Enumerize

    enumerize :status, in: [:created, :in_progress, :finished]
    enumerize :mode, in: [:full, :semi]

    serialize :table_numbers, Array

    belongs_to :bracket_configuration
    has_many :player_tournaments
    has_many :players, through: :player_tournaments
    has_many :matches
    has_many :match_players, through: :matches

    after_create :create_bracket, if: :full?

    def create_bracket
        Bracket.new.create(self.id)
    end

    def full?
        self.mode == :full
    end

    def available_tables
        self.table_numbers - self.matches.where(status: :in_progress).pluck(:table_number)
    end
end
