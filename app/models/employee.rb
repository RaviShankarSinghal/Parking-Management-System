class Employee < ApplicationRecord
  enum :user_type, [:employee, :admin], default: :employee
  has_many :vechiles
  scope :show, -> { where(:user_type => "employee")}
  # Ex:- scope :active, -> {where(:active => true)}
end
