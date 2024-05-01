require "rails_helper"

RSpec.describe "/stores", type: :request do
  describe "GET /show" do
    it "renders a successful response with stores data" do
      store = Store.create! name: "New Store"
      get "/stores/#{store.id}", headers: {"Accept" => "application/json"}
      json = JSON.parse(response.body)

      expect(json["name"]).to eq "New Store"
    end
  end
end