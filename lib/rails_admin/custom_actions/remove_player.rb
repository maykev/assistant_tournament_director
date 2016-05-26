require 'rails_admin/config/actions'
require 'rails_admin/config/actions/base'

module RailsAdmin
    module Config
        module Actions
            class RemovePlayer < RailsAdmin::Config::Actions::Base
                RailsAdmin::Config::Actions.register(self)
            end
        end
    end
end
