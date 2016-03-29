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
        begin
            tournament = Tournament.find(params[:tournament_id])
        rescue ActiveRecord::RecordNotFound
            render status: :not_found, body: 'tournament'
            return
        end

        match = Match.create!(tournament: tournament, table_number: params[:table], status: :created)

        params[:players].each do |player_id|
            begin
                player = tournament.players.find(player_id)
            rescue
                render status: :not_found, body: "player #{player_id}"
                return
            end

            MatchPlayer.create!(match: match, player: player)
        end

        render status: :created, json: { id: match.id }
    end

    def update
        player_1 = Player.find(params[:players][0][:id])
        player_2 = Player.find(params[:players][1][:id])

        match = Match.find(params[:id])

        if match.status == :in_progress
            unless params[:override]
                head :conflict
                return
            end
        end

        match.update_attributes!(table_number: params[:table], status: params[:finished] ? :finished : :in_progress)

        MatchPlayer.find_by(match: match, player: player_1).update_attributes!(score: params[:players][0][:score])
        MatchPlayer.find_by(match: match, player: player_2).update_attributes!(score: params[:players][1][:score])

        head :ok
    rescue ActiveRecord::RecordNotFound
        head :not_found
    end
end
