class Product < ApplicationRecord
  include Discard::Model

  has_one_attached :image
  has_many :order_items
  has_many :orders, through: :order_items
  belongs_to :store
  validates :title, presence: true, length: {minimum: 3}
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :description, presence: true, length: {minimum: 10, maximum: 100}
  validates :category, presence: true
  scope :not_discarded, -> { where(discarded: false) }

<<<<<<< feature/implements-tests-api

=======
>>>>>>> main
end

 