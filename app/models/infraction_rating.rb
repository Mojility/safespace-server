class InfractionRating < ApplicationRecord
  belongs_to :infraction
  belongs_to :person

  validates :rating, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }
end
