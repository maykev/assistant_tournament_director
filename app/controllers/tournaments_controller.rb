class TournamentsController < ApplicationController
    def show
        tournament = Tournament.find(params[:id])

        return head :not_found unless tournament.full?

        @bracket = {}

        tournament.matches.order(bracket_position: :asc).each do |match|
            match_players = match.match_players.order(position: :asc)

            match_players.each do |match_player|
                key = "#{match.bracket_position}-P#{match_player.position}"
                @bracket[key] = {
                    name: match_player.player.full_name,
                    score: match_player.score,
                    level: match_player.player.level.name.downcase
                }
            end
        end

        bracket_size = tournament.bracket_configuration.size
        if bracket_size == 32
            render 'show32'
        elsif bracket_size == 64
            render 'show64'
        elsif bracket_size == 128
            render 'show128'
        end
    rescue ActiveRecord::RecordNotFound
        return head :not_found
    end

    def players
        @players = Tournament.find(params[:id]).players.order(:first_name, :last_name)
        render 'tournament_players'
    end
end
