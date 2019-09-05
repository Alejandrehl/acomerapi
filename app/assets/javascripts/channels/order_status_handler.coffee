App.order_status_handler = App.cable.subscriptions.create "OrderStatusHandlerChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
    handleRealTimeChangueOrderStatus(data['order_id'], data['old_status'], data['new_status'])