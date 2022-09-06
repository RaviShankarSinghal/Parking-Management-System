class Slot < ApplicationRecord
  belongs_to :floor
  has_many :vechiles
  enum :parking_status, [:full, :empty], default: :empty
end
