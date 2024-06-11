class RefreshToken < ApplicationRecord
  belongs_to :user
  before_create :set_token

  private

  def set_token
    self.refresh_token = SecureRandom.hex(64)
  end

end
