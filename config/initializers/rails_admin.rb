Dir[Rails.root.join('lib', 'rails_admin', '**', '*.rb')].each { |file| require file }

RailsAdmin.config do |config|
    config.authenticate_with do
        warden.authenticate! scope: :admin
    end

    config.authorize_with(:cancan)
    config.current_user_method(&:current_admin)

    config.actions do
        dashboard
        index
        new
        export
        bulk_delete
        show
        edit
        delete
        show_in_app
        start_tournament
        list_tournament_players
        add_player
        remove_player
    end

    config.model Admin do
        include_fields :email, :password, :password_confirmation
    end

    config.model BracketConfiguration do
        include_all_fields
    end

    config.model Level do
        include_fields :name, :games_required, :players
    end

    config.model Match do
        list do
            include_fields :id, :tournament, :status, :table_number, :bracket_position, :match_players
        end

        show do
            include_fields :id, :tournament, :status, :table_number, :bracket_position, :match_players
        end

        edit do
            include_fields :id, :tournament, :status, :table_number, :bracket_position, :match_players
        end
    end

    config.model MatchPlayer do
        include_all_fields
    end

    config.model Player do
        object_label_method :full_name
        include_fields :id, :first_name, :last_name, :level
    end

    config.model Tournament do
        list do
            field :id
            field :name
            field :status
            field :number_of_players
            field :mode
            field :table_numbers, :string
        end

        edit do
            field :id
            field :name
            field :status
            field :race
            field :final_race
            field :table_numbers
            field :mode
            field :players
        end
    end
end
