class Room < ApplicationRecord
  has_many :memberships, dependent: :destroy
  has_many :posts, dependent: :destroy
end
