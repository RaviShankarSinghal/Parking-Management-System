class Vechile < ApplicationRecord
  belongs_to :slot
  scope :search, lambda {|query|where(["number LIKE?","%#{query}%"])}
  validates :number, presence: true, uniqueness: true
  # Ex:- scope :active, -> {where(:active => true)}
end
