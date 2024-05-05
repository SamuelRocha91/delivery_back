require 'rails_helper'

RSpec.describe "stores/edit", type: :view do
  include Devise::Test::ControllerHelpers # Inclua Devise::Test::ControllerHelpers

  let(:store) {
    Store.create!(
      name: "MyString",
      user: create(:user)
    )
  }

  let(:sellers) do
    [
      create(:user, email: "seller1@example.com", role: 'seller'),
      create(:user, email: "seller2@example.com", role: 'seller'),
      create(:user, email: "seller3@example.com", role: 'seller')
    ]
  end

  before(:each) do
    assign(:store, store)
    assign(:sellers, sellers)
    allow(view).to receive(:current_user).and_return(create(:user_admin))
  end

  it "renders the edit store form" do
    render

    assert_select "form[action=?][method=?]", store_path(store), "post" do

      assert_select "input[name=?]", "store[name]"
    end
  end
end
