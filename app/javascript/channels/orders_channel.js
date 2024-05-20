import consumer from "channels/consumer"

consumer.subscriptions.create("OrdersChannel", {
  connected() {
   console.log('conectado')
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    console.log('dado recebido', data)
  }
});
