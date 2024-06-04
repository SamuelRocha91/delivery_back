class OrdersChannel < ApplicationCable::Channel
  def subscribed
    stream_from "orders_channel_user_#{current_user.id}"
  end

  def unsubscribed
    ActionCable.server.broadcast "orders_chanel", message: data['message'] 
  end
end
