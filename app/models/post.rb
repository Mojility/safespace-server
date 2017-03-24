class Post < ApplicationRecord
  belongs_to :room
  belongs_to :person
end
