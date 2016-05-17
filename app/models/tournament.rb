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

    after_save :create_bracket, if: :full?

    def create_bracket
        if self.bracket_configuration.blank?
            bracket_configuration = BracketConfiguration.where('size >= ?', self.players.count).order(:size).first
            self.update_attributes!(bracket_configuration: bracket_configuration)
        end

        if self.status == :in_progress
            # Clear any previously created bracket matches
            Match.where(tournament: self).destroy_all

            Bracket.new.create(self.id)
        end
    end

    def full?
        self.mode == :full
    end

    def available_tables
        self.table_numbers - self.matches.where(status: :in_progress).pluck(:table_number)
    end
end
