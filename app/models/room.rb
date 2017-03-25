class Room < ApplicationRecord
  has_many :memberships, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :people, through: :memberships
  has_many :infractions
end
