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

    collection :new_match do
      collection true
      link_icon 'icon-plus'
      pjax false
      visible do
        authorized? && bindings[:abstract_model].model.to_s == "Match"
      end
    end

    export
    bulk_delete
    show
    edit

    member :edit_match, :edit_match do
      member true
      link_icon 'icon-pencil'
      pjax false
      visible do
        authorized? && bindings[:abstract_model].model.to_s == "Match"
      end
    end

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
      include_fields :table_number, :match_players
      field :status, :enum
      configure :match_players do
        label "Match score"
      end
    end

    show do
      include_all_fields
    end
  end

  config.model Player do
    object_label_method :full_name

    list do
      include_fields :membership_number, :first_name, :last_name, :display_name, :email, :level
    end

    show do
      include_all_fields
    end

    edit do
      include_fields :membership_number, :first_name, :last_name, :display_name, :email, :level
    end
  end

  config.model Tournament do
    edit do
      include_fields :name, :status, :start_date, :end_date, :players
    end
  end
end