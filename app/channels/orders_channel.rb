class OrdersChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chat_#{params[:room]}" 
  end

  def unsubscribed
    ActionCable.server.broadcast "orders_chanel", message: data['message'] 
  end
end
