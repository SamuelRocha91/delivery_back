require 'rails_helper'

RSpec.describe "Products", type: :request do
  let(:user) {
    create(:user)
  }

  let(:admin) {
    create(:user_admin)
  }

  before {
    sign_in(admin)
  }

  before {
    Product.create(store: Store.create(name: "Store 3", user: user), title: "japan", price: 9.50)
  }

  describe "GET /listing" do
    it "renders a successful response" do
      get listing_url
      expect(response). to be_successful
      expect(response.body).to include "japan"
    end
  end
  
end