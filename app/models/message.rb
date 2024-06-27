class Message < ApplicationRecord
  belongs_to :order
  validates :user, presence: true
  validates :message, presence: true
  validates :order_id, presence: true
end
