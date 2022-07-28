class ParkingSpot < ApplicationRecord
  enum :status, [:empty, :full], default: :empty
  has_many :vechiles
end