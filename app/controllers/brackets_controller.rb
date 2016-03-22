class BracketsController < ApplicationController
    skip_before_action :verify_authenticity_token

    def create
        bracket = Bracket.new.create(params[:tournament_id])

        puts bracket.inspect

        render json: bracket
    end

    def show

    end
end
