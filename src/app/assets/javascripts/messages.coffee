window.MessagesJs =
  init: ->
    $(document).on 'keypress', "input#content", (event) ->
      if event.keyCode is 13
        console.log("submitting", event.target.value)
        App.messages.create(event.target.value)
        event.target.value = ''
        event.preventDefault()
    $(document).on 'click', ".close", (event) ->
      elem = $(event.target).data('id')
      console.log("close is clicked", elem)
      App.messages.destroy(elem)
      event.preventDefault()
