App.notifications = App.cable.subscriptions.create "NotificationsChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
    # console.log( data['message'] )
    # count = parseInt($('#notification-number').text() )
    # $('#notification-number').text( (count + 1) )
    # handleChangueStatus = (id, status) ->

    #     location.reload()

    handleRealTimeOrder(data['id'])