class Level < ApplicationRecord
  has_many :players, dependent: :destroy, inverse_of: :level
end
