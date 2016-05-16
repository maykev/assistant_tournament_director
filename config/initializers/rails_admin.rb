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
            include_fields :id, :tournament, :bracket_position, :table_number, :match_players
        end

        show do
            include_fields :id, :tournament, :bracket_position, :table_number, :match_players
        end

        edit do
            include_fields :id, :bracket_position, :table_number
        end
    end

    config.model Player do
        object_label_method :full_name
        include_fields :id, :first_name, :last_name, :level
    end

    config.model Tournament do
        list do
            include_fields :id, :name, :status, :race, :final_race, :table_numbers, :mode
        end

        edit do
            include_fields :id, :name, :status, :race, :final_race, :table_numbers, :mode, :players
        end
    end
end
