class Order < ApplicationRecord
  belongs_to :buyer, class_name: "User"
  belongs_to :store
  has_many :order_items
  has_many :products, through: :order_items
  validate :buyer_role

  state_machine initial: :created do
    event :accept do
      transition created: :accepted
    end
  end

  private

  def buyer_role
    if !buyer.buyer?
      errors.add(:buyer, "should be a `user.buyer`")
    end
  end
end
