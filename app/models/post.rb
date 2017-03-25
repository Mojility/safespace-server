class Post < ApplicationRecord
  belongs_to :room
  belongs_to :person

  has_many :infraction_events
  has_many :emote_events
end
