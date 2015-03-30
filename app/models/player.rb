class Player < ActiveRecord::Base
  belongs_to :level, inverse_of: :players
  has_many :match_player

  def full_name
    "#{first_name} #{last_name}"
  end
end
