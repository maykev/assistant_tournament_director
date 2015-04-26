class Admin::MatchController < ApplicationController
  def create
    player_1 = Player.find(params[:player_1])
    player_2 = Player.find(params[:player_2])

    Match.where(table_number: params[:table_number]).update_all(status: :finished)

    Match.create!(table_number: params[:table_number], status: :created).tap do |match|
      MatchPlayer.create!(player: player_1, match: match, score: 9 - player_1.level.games_required)
      MatchPlayer.create!(player: player_2, match: match, score: 9 - player_2.level.games_required)
    end

    flash[:success] = "Match created succesfully"
    redirect_to "/admin/match"
  end

  def update
    match = Match.find(params[:id])
    match.update_attributes!(table_number: params[:table_number], status: params[:status])

    match_players = MatchPlayer.where(match: match)
    match_players.first.update_attributes!(player_id: params[:player_1], score: params[:player_1_score])
    match_players.last.update_attributes!(player_id: params[:player_2], score: params[:player_2_score])

    flash[:success] = "Match updated successfully"
    redirect_to "/admin/match"
  end
end