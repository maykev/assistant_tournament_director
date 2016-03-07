class Api::MatchesController < ApplicationController
    skip_before_action :verify_authenticity_token

    def index
        tournament = Tournament.find(params[:tournament])

        matches = [
            {
                id: 1,
                race: 9,
                tables: [1,5],
                players: [
                    {
                        id: 1,
                        full_name: 'Ryan Lepinski',
                        display_name: 'Ryan',
                        games_on_the_wire: 2
                    },
                    {
                        id: 2,
                        full_name: 'Kevin May',
                        display_name: 'Kevin',
                        games_on_the_wire: 1
                    }
                ]
            },
            {
                id: 2,
                race: 9,
                tables: [1,5],
                players: [
                    {
                        id: 3,
                        full_name: 'Oscar Dominguez',
                        display_name: 'Oscar',
                        games_on_the_wire: 0
                    },
                    {
                        id: 4,
                        full_name: 'Vilmos Foldes',
                        display_name: 'Vilmos',
                        games_on_the_wire: 0
                    }
                ]
            }
        ]

        render json: matches.to_json
    rescue ActiveRecord::RecordNotFound
        head :not_found
    end

    def create
        head :created
    end

    def update
        head :ok
    end
end
