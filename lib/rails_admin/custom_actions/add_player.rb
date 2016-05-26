require 'rails_admin/config/actions'
require 'rails_admin/config/actions/base'

module RailsAdmin
    module Config
        module Actions
            class AddPlayer < RailsAdmin::Config::Actions::Base
                register_instance_option :member do
                    true
                end

                register_instance_option :link_icon do
                    'fa fa-user-plus'
                end

                register_instance_option :pjax? do
                    false
                end

                register_instance_option :visible? do
                    authorized?
                end

                RailsAdmin::Config::Actions.register(self)
            end
        end
    end
end
