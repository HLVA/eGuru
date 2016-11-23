jQuery(document).on 'turbolinks:load', ->
  console.log 'loading...'

  App.global_chat = App.cable.subscriptions.create {
      channel: "MessagesChannel"
    },

    connected: ->
      # Called when the subscription is ready for use on the server

    disconnected: ->
      # Called when the subscription has been terminated by the server

    received: (data) ->
      console.log(data)
      # messages.append data['message']
      # messages_to_bottom()

    send_message: (message, conversation_id) ->
      @perform 'send_message', message: message, conversation_id: conversation_id
