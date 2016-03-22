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
      include_all_fields
    end

    show do
      include_all_fields
    end

    edit do
      include_all_fields
    end
  end

  config.model Match do
    list do
      include_fields :id, :bracket_position, :match_players
    end

    show do
      include_all_fields
    end

    edit do
      include_all_fields
    end
  end

  config.model Player do
    object_label_method :full_name

    list do
      include_all_fields
    end

    show do
      include_all_fields
    end

    edit do
      include_all_fields
    end
  end

  config.model Tournament do
    edit do
      include_all_fields
    end
  end
end
