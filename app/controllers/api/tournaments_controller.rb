class Api::TournamentsController < ApplicationController
    skip_before_action :verify_authenticity_token

    def index
        tournaments = Tournament.where(status: :in_progress).select(:id, :name, :table_numbers, :mode)

        render json: tournaments.to_json
    end

    def tables
        if params[:id] == "1"
            render json: [1,2,3,4,5].to_json
        elsif params[:id] == "2"
            render json: [1,2,3,4,5,6,7,8,9,10].to_json
        else
            head :not_found
        end
    end
end
