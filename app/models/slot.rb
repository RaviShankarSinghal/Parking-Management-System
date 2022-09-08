class Slot < ApplicationRecord
  belongs_to :floor
  has_many :vechiles
  validates :slot_number, comparison: {less_than: 11, greater_than: 0}
  enum :parking_status, [:full, :empty], default: :empty
end
