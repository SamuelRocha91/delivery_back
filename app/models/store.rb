class Store < ApplicationRecord
  belongs_to :user
  validates :name, presence: true, length: {minimum: 3}
  before_validation :ensure_seller

  private

  def ensure_seller
    self.user = nil if self.user && !self.user.seller?
  end
end
