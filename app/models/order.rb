class Order < ApplicationRecord
  belongs_to :buyer, class_name: "User"
  belongs_to :store
  validate :buyer_role

  private

  def buyer_role
    if !buyer.buyer?
      errors.add(:buyer, "should be a `user.buyer`")
    end
  end
end
