class MessagesChannel < ApplicationCable::Channel
  
  def subscribed
    stream_from "conversation-#{verified_user.id}"
    p "vao trong subscribed" + "conversation-#{verified_user.id}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def receive(payload)  
    p 'da nhan message: ' + payload["message"]
    p 'da nhan user: ' + verified_user.inspect
    Message.create!(body: payload['message'], conversation_id: payload['conversation_id'], user: verified_user)
    # ActionCable.server.broadcast "room#{message.chatroom_id}:messages", message: render_message(message)
  end

  def send_message(data)
    user = User.find(data['user_id'])
    p 'put somthing out'    
    Message.create!(body: data['message'], conversation_id: data['conversation_id'], user_id: data['user_id'])
  end

  def test(data)
    ActionCable.server.broadcast('messages', message: "Test: #{data}")
  end

  def create(data)
    message = Message.create(content: data["message"], ip: current_ip)
    ActionCable.server.broadcast('messages', action: 'append', data: render_message(message))
  end

  def destroy(data)
    message = Message.find(data["id"]).destroy
    ActionCable.server.broadcast 'messages', action: 'remove', data: "#message_#{message.id}"
  end

  private
  def render_message(message)
    ApplicationController.render(
      partial: 'messages/message',
      locals: {message: message}
    )
  end


end
