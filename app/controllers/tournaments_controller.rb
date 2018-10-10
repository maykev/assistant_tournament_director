class TournamentsController < ApplicationController
    def index
        tournament = Tournament.includes(:bracket_configuration).where(status: :in_progress).where.not('bracket_configurations.id' => nil).last

        if tournament.present?
            redirect_to tournament_path(tournament.id)
        else
            render :index
        end
    end

    def show
        tournament = Tournament.find(params[:id])

        return head :not_found unless tournament.full?

        @bracket = {}

        tournament.matches.order(bracket_position: :asc).each do |match|
            match_players = match.match_players.order(position: :asc)

            match_players.each do |match_player|
                key = "#{match.bracket_position}-P#{match_player.position}"
                @bracket[key] = {
                    name: match_player.player.try(:full_name),
                    score: match_player.score,
                    level: match_player.player.try(:level).try(:name).try(:downcase)
                }
            end
        end

        if tournament.id == 43
            render 'crockett'
        else
            bracket_size = tournament.bracket_configuration.size
            if bracket_size == 32
                render 'show32'
            elsif bracket_size == 64
                render 'show64'
            elsif bracket_size == 128
                render 'show128'
            elsif bracket_size == 256
                render 'show256'
            end
        end
    rescue ActiveRecord::RecordNotFound
        return head :not_found
    end

    def players
        @players = Tournament.find(params[:id]).players.order(:first_name, :last_name)
        render 'tournament_players'
    end
end
