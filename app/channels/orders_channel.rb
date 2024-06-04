class OrdersChannel < ApplicationCable::Channel
  def subscribed
    order = Order.find(params[:id])
    stream_for order
  end

  def unsubscribed
    stop_all_streams
  end

  def self.notify_user(user, order, message)
    OrdersChannel.broadcast_to(
      user,
      order_id: order.id,
      message: message
    )
  end
end
