class MessagesChannel < ApplicationCable::Channel
  def subscribed
    stream_from "messages"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def test(data)

    ActionCable.server.broadcast('messages', message: "Test: #{data}")
  end
  def create
    @message = Message.new message_params
    @message.ip = request.remote_ip
    @message.save!
    ActionCable.server.broadcast 'messages', action: 'append', data: render_message(@message)
    redirect_to messages_path
  end

  def message_params
    params.require(:message).permit(:content)
  end
end