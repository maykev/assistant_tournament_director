class MatchPlayer < ApplicationRecord
    belongs_to :match
    belongs_to :player


    def full_name
        "#{player.first_name} #{player.last_name}"
    end

    def rails_admin_display
        if player then
            "#{player.first_name} #{player.last_name} (#{score})"
        else
            ""
        end
    end
end
