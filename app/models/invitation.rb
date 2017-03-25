class Invitation < ApplicationRecord
  belongs_to :room

  before_create :make_invitation

  private

  def make_invitation
    self.token = SecureRandom.hex(3)
  end
end
