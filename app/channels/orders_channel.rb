class OrdersChannel < ApplicationCable::Channel
  def subscribed
    stream_from "orders_chanel" 
  end

  def unsubscribed
    ActionCable.server.broadcast "orders_chanel", message: data['message'] 
  end
end
