class Level < ActiveRecord::Base
  has_many :players, dependent: :destroy, inverse_of: :level
end
