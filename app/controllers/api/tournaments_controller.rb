class Api::TournamentsController < ApplicationController
    skip_before_action :verify_authenticity_token

    def index
        tournaments = {
            mode: 'full',
            tournaments: [
                {
                    id: 1,
                    name: 'tournament 1',
                    tables: [1,2,3,4,5]
                },
                {
                    id: 2,
                    name: 'tournament 2',
                    tables: [1,2,3,4,5,6,7,8,9,10]
                }
            ]
        }

        render json: tournaments.to_json
    end
end
