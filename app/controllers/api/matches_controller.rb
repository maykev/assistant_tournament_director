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
                tournament_id: tournament.id,
                race: tournament.race,
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

        player_number = 1
        params[:players].each do |player_id|
            begin
                player = tournament.players.find(player_id)
            rescue
                render status: :not_found, body: "player #{player_id}"
                return
            end

            MatchPlayer.create!(match: match, player: player, position: player_number)
            player_number = player_number + 1
        end

        matchJson = {
            id: match.id,
            race: tournament.reload.race,
            players: []
        }

        match.reload.match_players.order(position: :asc).each do |match_player|
            matchJson[:players].push({
                id: match_player.player.id,
                full_name: match_player.player.full_name,
                display_name: match_player.match.display_name(match_player.position),
                games_on_the_wire: tournament.race - match_player.player.level.games_required
            })
        end

        render status: :created, json: matchJson.to_json
    end

    def update
        player_1 = Player.find(params[:players][0][:id])
        player_2 = Player.find(params[:players][1][:id])

        match = Match.find(params[:id])

        if match.status == :created
            tables_in_use = match.tournament.matches.where(status: :in_progress).pluck(:table_number)

            if tables_in_use.include?(params[:table])
                render status: :conflict, body: "table"
                return
            end
        end

        MatchPlayer.find_by(match: match, player: player_1).update_attributes!(score: params[:players][0][:score])
        MatchPlayer.find_by(match: match, player: player_2).update_attributes!(score: params[:players][1][:score])
        
        match.update_attributes!(table_number: params[:table], status: params[:finished] ? :finished : :in_progress)

        head :ok
    rescue ActiveRecord::RecordNotFound
        head :not_found
    end
end
