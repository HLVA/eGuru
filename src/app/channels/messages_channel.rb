class MessagesChannel < ApplicationCable::Channel
  def subscribed
    stream_from "messages_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def send_message(data)
    user = User.find(data['user_id'])
    user.messages.create!(body: data['message'], conversation_id: data['conversation_id'])
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
