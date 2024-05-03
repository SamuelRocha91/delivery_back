class Product < ApplicationRecord
  has_many :orders, through: :order_items
  belongs_to :store
end
