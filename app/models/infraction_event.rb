class InfractionEvent < ApplicationRecord
  belongs_to :infraction
  belongs_to :post
  belongs_to :person
end
