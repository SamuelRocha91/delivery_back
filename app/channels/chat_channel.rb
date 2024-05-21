class ChatChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chat_room#{params[:room]}" 
  end

  def unsubscribed
      ActionCable.server.broadcast "chat_room#{params[:room]}", message: data['message'] 
  end

  def speak(data)
     ActionCable.server.broadcast "chat_room#{params[:room]}", data['message']
  end
end
