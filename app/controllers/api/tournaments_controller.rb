class Api::TournamentsController < ApplicationController
    skip_before_action :verify_authenticity_token

    def index
        tournaments = [
            {
                id: 1,
                name: 'tournament 1',
                tables: [1,2,3,4,5],
                mode: 'full',
            },
            {
                id: 2,
                name: 'tournament 2',
                tables: [1,2,3,4,5,6,7,8,9,10],
                mode: 'semi',
            }
        ]

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
