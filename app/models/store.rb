class Store < ApplicationRecord
  has_one_attached :avatar
  belongs_to :user
  has_many :products
  validates :name, presence: true, length: {minimum: 3}
  before_validation :ensure_seller
  
  private

  def ensure_seller
    self.user = nil if self.user && !self.user.seller?
  end
end
