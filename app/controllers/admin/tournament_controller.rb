class Admin::TournamentController < ApplicationController
    def update
        if params[:cancel]
            redirect_to "/admin/tournament"
        else
            Bracket.new.add_player(params[:id], params[:player])
            redirect_to "/admin/tournament"
        end
    rescue ActiveRecord::RecordNotFound
        head :not_found
    end
end
