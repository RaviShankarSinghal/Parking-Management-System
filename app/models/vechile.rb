class Vechile < ApplicationRecord
  belongs_to :employee
  scope :search, lambda {|query|where(["name LIKE?","%#{query}%"])}   
  validates :number, presence: true, uniqueness: true
  # Ex:- scope :active, -> {where(:active => true)}
end
