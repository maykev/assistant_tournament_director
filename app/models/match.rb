class Match < ApplicationRecord
    extend Enumerize
    enumerize :status, in: [:created, :in_progress, :finished]

    belongs_to :tournament
    has_many :match_players, dependent: :destroy
    has_many :players, through: :match_players

    after_save :update_bracket, if: :full_tournament_and_finished?

    def full_tournament_and_finished?
        return true if self.tournament.full? && self.finished?
    end

    def race
        match.tournament.matches.where(status: :created).count > 1 ? match.tournament.race : match.tournament.final_race
    end

    def display_name(position)
        display_names = []
        match_players = self.match_players.order(position: :asc)

        if match_players.first.player.first_name != match_players.last.player.first_name
            display_names = [match_players.first.player.first_name, match_players.last.player.first_name]
        elsif match_players.first.player.last_name[0] != match_players.last.player.last_name[0]
            display_names = ["#{match_players.first.player.first_name} #{match_players.first.player.last_name[0]}", "#{match_players.last.player.first_name} #{match_players.last.player.last_name[0]}"]
        else
            display_names = ["#{match_players.first.player.first_name[0]}. #{match_players.first.player.last_name}", "#{match_players.last.player.first_name[0]}. #{match_players.last.player.last_name}"]
        end

        display_names[0] = display_names[0][0..8]
        display_names[1] = display_names[1][0..8]

        return display_names[position - 1]
    end

    def finished?
        self.status == :finished
    end

    def update_bracket
        Bracket.new.update(self.id)
    end
end
