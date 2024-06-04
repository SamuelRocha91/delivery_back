class Order < ApplicationRecord
  belongs_to :buyer, class_name: "User"
  belongs_to :store
  has_many :order_items
  has_many :products, through: :order_items
  validate :buyer_role
  accepts_nested_attributes_for :order_items

  state_machine initial: :created do
     event :pay do
        transition created: :payment_pending
     end

    event :confirm_payment do
        transition payment_pending: :payment_confirmed
    end

    event :payment_failed do
        transition payment_pending: :payment_failed
    end
    
    event :confirm_payment do
      transition created: :accepted
    end

     event :cancel do
        transition [:created, :accepted, :in_progress, :ready_for_delivery, :in_delivery, :payment_pending, :payment_failed, :payment_confirmed,] => :canceled
      end

     event :start_progress do
       transition accepted: :in_progress
     end

    event :ready_for_delivery do
      transition in_progress: :ready_for_delivery
    end

    event :start_delivery do
      transition ready_for_delivery: :in_delivery
    end

    event :deliver do
      transition in_delivery: :delivered
    end
  end

  private

  def buyer_role
    if buyer && !buyer.buyer?
      errors.add(:buyer, "should be a `user.buyer`")
    end
  end
end
