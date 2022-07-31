class Vechile < ApplicationRecord
  belongs_to :employee
  scope :search, lambda {|query|where(["name LIKE?","%#{query}%"])}   
  # Ex:- scope :active, -> {where(:active => true)}
end
