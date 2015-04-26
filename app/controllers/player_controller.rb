class PlayerController < ApplicationController
  def index
    players = {players: []}

    Player.order(:first_name).all do |player|
      players[:players].append({id: player.id, full_name: player.full_name})
    end
    
    render json: players.to_json
  end
end