class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message)
  	render_result = render_message(message)

  	p 'recipient_id la: ' + "conversation-#{message.conversation.recipient_id}"
  	p 'sender la: ' + "conversation-#{message.user_id}"
    ActionCable.server.broadcast "conversation-#{message.conversation.recipient_id}", message: render_result
    ActionCable.server.broadcast "conversation-#{message.conversation.sender_id}", message: render_result
  end

  private

  def render_message(message)
    ApplicationController.renderer.render(partial: 'messages/message', locals: {message: message})
  end
end