require 'rails_admin/config/actions'
require 'rails_admin/config/actions/base'

module RailsAdmin
    module Config
        module Actions
            class ListTournamentPlayers < RailsAdmin::Config::Actions::Base
                register_instance_option :member do
                    true
                end

                register_instance_option :link_icon do
                    'fa fa-users'
                end

                register_instance_option :pjax? do
                    false
                end

                register_instance_option :visible? do
                    authorized?
                end

                register_instance_option :controller do
                    Proc.new do
                        redirect_to "/tournaments/#{@object.id}/players"
                    end
                end

                RailsAdmin::Config::Actions.register(self)
            end
        end
    end
end
