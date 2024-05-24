class Store < ApplicationRecord
  include Discard::Model

  has_one_attached :avatar
  belongs_to :user
  has_many :products, dependent: :destroy
  validates :name, presence: true, length: {minimum: 3}
  before_validation :ensure_seller
  scope :not_discarded, -> { where(discarded: false) }

<<<<<<< feature/implements-tests-api
=======

>>>>>>> main
  private

  def ensure_seller
    self.user = nil if self.user && !self.user.seller?
  end
end
