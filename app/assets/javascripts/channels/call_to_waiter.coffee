App.call_to_waiter = App.cable.subscriptions.create "CallToWaiterChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
    id_usuario = parseInt($('#id_current_user').text() )
    if data['table_user_id'] == id_usuario
      switch data['reason']
        when 'Pedir la cuenta'
          pedirCuenta(data['table_id'])
        when 'Pedir mas'
          pedirMas(data['table_id'])
        when 'Tengo un problema'
          problemaMesa(data['table_id'])
        else
          problemaGeneral(data['table_id'])
    else
    console.log(`data['table_user_id']`)
    console.log(`id_usuario`)
      