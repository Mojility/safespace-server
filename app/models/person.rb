class Person < ApplicationRecord
  has_many :memberships, dependent: :destroy
  has_many :people
  has_many :rooms, through: :memberships
end
