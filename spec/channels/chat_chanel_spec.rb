require 'rails_helper'

RSpec.describe ChatChannel, type: :channel do
  let(:user) { create(:user, :seller) }
  let(:credential) { Credential.create_access(:seller) }
  let(:signed_in) { api_sign_in(user, credential) }
  let(:store) { create(:store, user: user) }
  let(:product) { create(:product, store: store) }
  let!(:order) { create(:order, store: store) }
  let!(:order_item) { create(:order_item, order: order, product: create(:product, store: store)) }

  before do
    stub_connection current_user: user
  end

  it 'subscribes to a chat room stream when order_id is provided' do
    subscribe(order_id: order.id)

    expect(subscription).to be_confirmed
    expect(subscription).to have_stream_from("chat_room#{order.id}")
  end

  it 'broadcasts messages when subscribed' do
    subscribe(order_id: order.id)
  
    expect {
      perform :speak, email: user.email, message: 'Hello', order_id: order.id
    }.to have_broadcasted_to("chat_room#{order.id}").with(user: user.email, message: 'Hello', order_id: order.id)
end


  it 'broadcasts a message when unsubscribed' do
    subscribe(order_id: order.id)
    expect {
      unsubscribe
    }.to have_broadcasted_to("chat_room#{order.id}").with(message: 'User has unsubscribed')
  end

  it 'creates and broadcasts a message when speak is called' do
    subscribe(order_id: order.id)

    expect {
      perform :speak, email: user.email, message: 'Hello', order_id: order.id
    }.to change(Message, :count).by(1)
     .and have_broadcasted_to("chat_room#{order.id}").with(user: user.email, message: 'Hello', order_id: order.id)
  end
end