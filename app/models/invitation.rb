class Invitation < ApplicationRecord
  belongs_to :room

  before_create :set_token

  private

  def set_token
    self.token = SecureRandom.hex(3)
  end
end
