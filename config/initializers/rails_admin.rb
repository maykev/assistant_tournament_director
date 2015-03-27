RailsAdmin.config do |config|
  config.authenticate_with do
    warden.authenticate! scope: :admin
  end

  config.authorize_with(:cancan)
  config.current_user_method(&:current_admin)

  config.navigation_static_links = {
    'Create Match' => '/match/new',
  }

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
    list do
      field :email
    end

    show do
      include_all_fields
    end

    edit do
      include_fields :email, :password, :password_confirmation
    end
  end

  config.model Level do
    list do
      include_fields :name, :games_required
    end

    show do
      include_all_fields
    end

    edit do
      include_fields :name, :games_required
    end
  end

  config.model Match do
    list do
      include_fields :table_number, :match_players, :finished
      configure :match_players do
        label "Match score"
      end
    end

    show do
      include_all_fields
    end
  end

  config.model Player do
    object_label_method :rails_admin_display

    list do
      include_fields :first_name, :last_name, :display_name, :email, :level
    end

    show do
      include_all_fields
    end

    edit do
      include_fields :first_name, :last_name, :display_name, :email, :level
    end
  end
end
