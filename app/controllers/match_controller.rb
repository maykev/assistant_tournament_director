class MatchController < ApplicationController
  def index
    respond_to do |format|
      format.html do
        @in_progress_matches = Match.includes(:match_players).where(status: :in_progress)
        render :index
      end
      format.json do
        matches = {matches: []}
        created_matches = Match.includes(:match_players).where(status: :created)
        created_matches.find_each do |created_match|
          match = {
            id: created_match.id,
            players: []
          }

          match_player_1 = created_match.match_players.first
          match_player_2 = created_match.match_players.last

          player_1 = {
            id: match_player_1.player.id,
            full_name: match_player_1.player.full_name,
            display_name: match_player_1.player.display_name,
            games_on_the_wire: match_player_1.score
          }

          player_2 = {
            id: match_player_2.player.id,
            full_name: match_player_2.player.full_name,
            display_name: match_player_2.player.display_name,
            games_on_the_wire: match_player_2.score
          }

          match[:players].append(player_1)
          match[:players].append(player_2)
          matches[:matches].append(match)
        end

        render json: matches.to_json
      end
    end
  end

  def update
    {
      players: [
        {
          id: 1,
          score: 4
        },
        {
          id: 2,
          score: 5
        }
      ]
    }

    MatchPlayer.where(match_id: params[:id], player_id: params[:players][0][:id]).first.update_attributes!(score: params[:players][0][:score])
    MatchPlayer.where(match_id: params[:id], player_id: params[:players][1][:id]).first.update_attributes!(score: params[:players][1][:score])

    head :ok
  end
end