class Api::TournamentsController < ApplicationController
    skip_before_action :verify_authenticity_token

    def index
        tournaments = Tournament.where(status: :in_progress).select(:id, :name, :table_numbers, :mode)

        render json: tournaments.to_json
    end

    def tables
        tournament = Tournament.find(params[:id])

        available_tables = tournament.table_numbers - tournament.matches.where(status: :in_progress).pluck(:table_number)

        render json: available_tables.to_json
    rescue ActiveRecord::RecordNotFound
        head :not_found
    end
end
