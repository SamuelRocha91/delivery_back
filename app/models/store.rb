class Store < ApplicationRecord
  include Discard::Model
  has_one_attached :avatar
  belongs_to :user
  has_many :products, dependent: :destroy
  validates :name, presence: true, length: {minimum: 3}
  before_validation :ensure_seller
  after_discard :discard_associated_products
  after_undiscard :undiscard_associated_products
  enum :category, [:bar,
  :depósito, :lanchonete, :loja, :mercado, :restaurante]

  private

  def ensure_seller
    self.user = nil if self.user && !self.user.seller?
  end

  def discard_associated_products
    products.each(&:discard)
  end

  def undiscard_associated_products
    products.each(&:undiscard)
  end

end
