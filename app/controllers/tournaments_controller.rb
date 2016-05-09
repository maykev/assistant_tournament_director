class TournamentsController < ApplicationController
    def show
        tournament = Tournament.find(params[:id])
        @bracket = {}

        tournament.matches.order(bracket_position: :asc).each do |match|
            match_players = match.match_players.order(position: :asc)

            match_players.each do |match_player|
                key = "#{match.bracket_position}-P#{match_player.position}"
                puts key
                @bracket[key] = { name: match_player.player.full_name, score: match_player.score }
            end
        end

        pp @bracket

        render 'show32'
    end
end
