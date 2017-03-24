class Person < ApplicationRecord
  has_many :memberships, dependent: :destroy
  has_many :people
end
