class PlayerController < ApplicationController
  def index
    players = {players: []}
    tournament = Tournament.where(status: "in_progress")

    if tournament.present?
      tournament.first.players.order(:first_name).each do |player|
        players[:players].append({id: player.id, full_name: player.full_name})
      end
    else
      Player.order(:first_name).each do |player|
        players[:players].append({id: player.id, full_name: player.full_name})
      end
    end

    render json: players.to_json
  end
end