class MatchController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    respond_to do |format|
      format.html do
        @in_progress_matches = Match.includes(:match_players).where(status: :in_progress).order(:table_number)
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

          match_player_1 = created_match.match_players.order(:id).first
          match_player_2 = created_match.match_players.order(:id).last

          player_1 = {
              id: match_player_1.player.id,
              full_name: match_player_1.player.full_name,
              display_name: match_player_1.player.display_name(match_player_1.position),
              games_on_the_wire: match_player_1.score
          }

          player_2 = {
              id: match_player_2.player.id,
              full_name: match_player_2.player.full_name,
              display_name: match_player_2.player.display_name(match_player_2.position),
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

  def create
    player_1 = Player.find(params[:players][0][:id])
    player_2 = Player.find(params[:players][1][:id])

    Match.where(table_number: params[:table_number], status: :in_progress).update_all(status: :finished)
    Match.joins(:match_players).where(status: :in_progress, match_players: {player: player_1}).update_all(status: :finished)
    Match.joins(:match_players).where(status: :in_progress, match_players: {player: player_2}).update_all(status: :finished)

    match = Match.create!(table_number: params[:table_number], status: :in_progress)
    match_player_1 = MatchPlayer.create!(match: match, player: player_1, score: 9 - player_1.level.games_required)
    match_player_2 = MatchPlayer.create!(match: match, player: player_2, score: 9 - player_2.level.games_required)

    match_json = {
        id: match.id,
        table_number: match.table_number,
        players: []
    }

    display_names = create_display_names(match_player_1.player, match_player_2.player);

    match_player_1_json = {
        id: match_player_1.player.id,
        full_name: match_player_1.player.full_name,
        display_name: display_names[0],
        games_on_the_wire: match_player_1.score
    }

    match_player_2_json = {
        id: match_player_2.player.id,
        full_name: match_player_2.player.full_name,
        display_name: display_names[1],
        games_on_the_wire: match_player_2.score
    }

    match_json[:players].append(match_player_1_json)
    match_json[:players].append(match_player_2_json)

    render json: match_json.to_json
  end

  def update
    player_1 = Player.find(params[:players][0][:id])
    player_2 = Player.find(params[:players][1][:id])

    match = Match.find(params[:id])
    match.update_attributes!(status: :in_progress)

    MatchPlayer.find_by(match: match, player: player_1).update_attributes!(score: params[:players][0][:score])
    MatchPlayer.find_by(match: match, player: player_2).update_attributes!(score: params[:players][1][:score])

    head :ok
  rescue => e
    Rails.logger.warn(e.inspect)
  end

  def create_display_names(player_1, player_2)
    display_names = []

    if player_1.first_name != player_2.first_name
      display_names = [player_1.first_name, player_2.first_name]
    elsif player_1.last_name[0] != player_2.last_name[0]
      display_names = ["#{player_1.first_name} #{player_1.last_name[0]}", "#{player_2.first_name} #{player_2.last_name[0]}"]
    else
      display_names = ["#{player_1.first_name[0]}. #{player_1.last_name}", "#{player_2.first_name[0]}. #{player_2.last_name}"]
    end

    display_names[0] = display_names[0][0..8]
    display_names[1] = display_names[1][0..8]

    return display_names
  end
end
