class Api::PlayersController < ApplicationController
    def index
        players = {players: []}

        if params[:tournament]
            tournament = Tournament.find(params[:tournament])
        else
            tournament = Tournament.where(status: "in_progress").first
        end

        if tournament.present?
            tournament.players.order(:first_name).each do |player|
                players[:players].append({id: player.id, full_name: player.full_name})
            end
        else
            Player.order(:first_name).each do |player|
                players[:players].append({id: player.id, full_name: player.full_name})
            end
        end

        render json: players.to_json
    rescue ActiveRecord::RecordNotFound => e
        head :not_found
    end
end
