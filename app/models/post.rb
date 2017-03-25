class Post < ApplicationRecord
  belongs_to :room
  belongs_to :person

  has_many :infraction_events
  has_many :emote_events

  def emotes
    events = self.emote_events
    event_ids = events.map { |e| e.emote.id }
    unique_ids = event_ids.uniq
    unique_ids.map {|id| {id: id, quantity: event_ids.count(id)}}
  end

  def infractions
    events = self.infraction_events
    event_ids = events.map { |e| e.infraction.id }
    unique_ids = event_ids.uniq
    unique_ids.map {|id| {id: id, quantity: event_ids.count(id)}}
  end
end
