require 'rails_admin/config/actions'
require 'rails_admin/config/actions/base'

module RailsAdmin
    module Config
        module Actions
            class StartTournament < RailsAdmin::Config::Actions::Base
                register_instance_option :member do
                    true
                end

                register_instance_option :link_icon do
                    'fa fa-play-circle'
                end

                register_instance_option :pjax? do
                    false
                end

                register_instance_option :visible? do
                    authorized?
                end

                register_instance_option :controller do
                    Proc.new do
                        @object.start
                        flash[:notice] = "Started #{@object.name} tournament"
                        redirect_to back_or_index
                    end
                end

                RailsAdmin::Config::Actions.register(self)
            end
        end
    end
end
