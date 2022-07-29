class ParkingSpot < ApplicationRecord
  enum :status, [:empty, :full], default: :empty
end