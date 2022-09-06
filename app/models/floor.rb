class Floor < ApplicationRecord
  belongs_to :employee
  has_many :slots
end
