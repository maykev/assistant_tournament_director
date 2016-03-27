class Api::MatchesController < ApplicationController
    skip_before_action :verify_authenticity_token

    def index
        tournament = Tournament.find(params[:tournament])
        matches = tournament.matches.where(status: :created)
        json = []

        matches.each do |match|
            if match.match_players.count < 2
                next
            end

            matchJson = {
                id: match.id,
                race: tournament.race,
                tables: tournament.available_tables,
                players: []
            }

            match.match_players.order(position: :asc).each do |match_player|
                matchJson[:players].push({
                    id: match_player.player.id,
                    full_name: match_player.player.full_name,
                    display_name: match_player.match.display_name(match_player.position),
                    games_on_the_wire: tournament.race - match_player.player.level.games_required
                })
            end

            json.push(matchJson)
        end

        render json: json.to_json
    rescue ActiveRecord::RecordNotFound
        head :not_found
    end

    def create
        head :created
    end

    def update
        head :ok
    end
end
