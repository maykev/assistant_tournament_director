class MatchPlayer < ActiveRecord::Base
  belongs_to :match
  belongs_to :player

  def rails_admin_display
    "#{player.first_name} #{player.last_name} (#{score})"
  end

  rails_admin do
    object_label_method :rails_admin_display
    hide
  end
end