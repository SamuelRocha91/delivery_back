class ChatChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chat_room#{params[:order_id]}" 
  end

  def unsubscribed
    ActionCable.server.broadcast "chat_room#{params[:order_id]}", message: "User has unsubscribed"
  end

  def speak(data)
    message_data = {
      user: 'desconhecido', 
      message: data['message']
    }
     ActionCable.server.broadcast "chat_room#{params[:order_id]}", message_data
  end
end
