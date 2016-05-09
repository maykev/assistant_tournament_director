class Api::TournamentsController < ApplicationController
    skip_before_action :verify_authenticity_token

    def index
        tournaments = Tournament.where(status: :in_progress).select(:id, :name, :table_numbers, :mode)

        render json: tournaments.to_json
    end

    def show
        tournament = Tournament.includes(:matches).find(params[:id])
        height = 30
        json = {
            name: tournament.name,
            playerWidth: 150,
            scoreWidth: 30,
            height: height,
            lineLength: 30,
            tournamentMatchPlayers: []
        }

        y = 0
        tournament.matches.where('bracket_position LIKE ?', 'W1%').order(:bracket_position).each do |match|
            first_player = match.match_players.order(:position).first
            second_player = match.match_players.order(:position).last

            if first_player
                json[:tournamentMatchPlayers].push({
                    bracketPosition: "#{match.bracket_position}-P1",
                    x: 500,
                    y: y,
                    name: first_player.full_name,
                    score: first_player.score
                })
            else
                json[:tournamentMatchPlayers].push({
                    bracketPosition: "#{match.bracket_position}-P1",
                    x: 500,
                    y: y
                })
            end

            y = y + height + 10

            if second_player && first_player != second_player
                json[:tournamentMatchPlayers].push({
                    bracketPosition: "#{match.bracket_position}-P2",
                    x: 500,
                    y: y,
                    name: second_player.full_name,
                    score: second_player.score
                })
            else
                json[:tournamentMatchPlayers].push({
                    bracketPosition: "#{match.bracket_position}-P2",
                    x: 500,
                    y: y
                })
            end

            y = y + height + 20
        end

        render json: json.to_json
    end

    def tables
        tournament = Tournament.find(params[:id])

        available_tables = tournament.table_numbers - tournament.matches.where(status: :in_progress).pluck(:table_number)

        render json: available_tables.to_json
    rescue ActiveRecord::RecordNotFound
        head :not_found
    end
end
