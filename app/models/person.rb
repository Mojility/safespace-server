class Person < ApplicationRecord
  has_many :memberships, dependent: :destroy
  has_many :people
  has_many :rooms, through: :memberships

  validates :email, uniqueness: true

  before_create :set_auth

  private

  def set_auth
    self.auth = SecureRandom.base64(256)
  end
end
