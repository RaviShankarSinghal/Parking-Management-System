class Employee < ApplicationRecord
  enum :user_type, [:employee, :admin], default: :employee
  has_many :floor
  scope :show, -> { where(:user_type => "employee")}
end
