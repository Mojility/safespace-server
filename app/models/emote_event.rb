class EmoteEvent < ApplicationRecord
  belongs_to :emote
  belongs_to :person
  belongs_to :post
end
