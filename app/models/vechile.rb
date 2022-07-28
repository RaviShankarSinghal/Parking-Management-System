class Vechile < ApplicationRecord
  belongs_to :employee
  belongs_to :parking_spots
end
