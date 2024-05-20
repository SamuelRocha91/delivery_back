import consumer from "channels/consumer"

consumer.subscriptions.create("ChatChannel", {
  connected() {
    console.log('canal de mensagens')
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
  }
});
