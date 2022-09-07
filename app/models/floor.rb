class Floor < ApplicationRecord
  belongs_to :employee
  has_many :slots , dependent: :destroy
  validates :employee_id, presence: true
end
