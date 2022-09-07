class Slot < ApplicationRecord
  belongs_to :floor
  has_many :vechiles
  validates :slot_number, comparison: {greater_than: 10}
  enum :parking_status, [:full, :empty], default: :empty
end
